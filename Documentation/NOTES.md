# Cabify Checkout

Para la solución del challenge, se creó una aplicación iOS.


## Características

- Xcode 10.2
- Swift 5
- Compatible con iOS11+


## Arquitectura

La aplicación está desarrollada siguiendo la estructura **Modelo Vista Presentador (MVP)** y, en general, utilizando **Dependency Injection (DI)** para crear las dependencias de los principales componentes.

**Modelo:** define los puntos de entrada (interfaz) de los servicios. Estos servicios se encargan principalmente de aplicar las reglas de negocio y la persistencia.
**Vista:** define el comportamiento de las interfaces de usuario (UI) de la aplicación. 
**Presentador:** funciona como responsable de recibir las interacciones de las vistas y responder adecuadamente utilizando la capa de servicios (Modelos)

Siguiendo estos principios, la aplicación está estructurada de la siguiente manera:

```
-
|
| - Config
| + Domain
   | - Models
| + UI
  | - ProductList
  | - Cart
  | - Checkout
  | - Payment
| + Persistence
  | -- Services
```

Config: archivos *.plist* y *.xcconfig* para el manejo de parámetros configurables.
Domain: modelos que representan las estructuras: *Productos*, *ShoppingCart*, *Promotion*, etc. **(Modelos)**
UI: Agrupa los archivos para cada pantalla (ej: *ProductList* contiene *ProductListViewController*, *ProductListPresenter*, etc.) **(Vista + Presentador)**
Persistence: Define la capa de servicios **(Modelo)**


### Dependency Injection

Para cada pantalla, se debe asignar las relaciones entre los Controllers, los Presenters y los Servicios.

En una aplicación típica, los controllers son los responsables de crear sus propias dependencias.  Por ejemplo:

```
class ProductListViewController : UIViewController {

    let presenter: ProductListPresenter = ProductListPresenter()
    
}

class ProductListPresenter {

    let productService: ProductService = ProductService()
    
}
```

El problema con este enfoque es que crea un alto acoplamiento entre las clases y además, resulta muy complicado de probar, ya que resulta complicado controlar el comportamiento de cada prueba.

Para solucionar este escenario, cada componente (Controller, Presenter, etc) recibe las dependencias que necesita. Y estas, a su vez, se declaran como interfaces (protocols).

```

// ProductListContracts.swift

protocol ProductListViewContract {
    var presenter: ProductListPresenterContract! { get set }
}

protocol ProductListPresenterContract {
    var view: ProductListViewContract! { get set }
}
```

```
class ProductListViewController : UIViewController, ProductListViewContract {
    var presenter: ProductListPresenterContract!
}

class ProductListPresenter : UIViewController, ProductListPresenterContract {
    weak var view: ProductListViewContract!
}

```

Es importante que la referencia del presenter a su vista sea definida como *weak*, de lo contrario, se crearían referencias circulares entre ellos al estarse referenciando con referencias *strong*

Luego, el encargado de crear y enlazar los componentes es UIContainer, un contenedor creado usando [Swinject](https://github.com/Swinject/Swinject)

```

// UIContainer.swift

let container = Container();

    container.register(ProductListViewController.self) { r in

    let controller = UIStoryboard.Scene.Products.productList;
    controller.router = ProductListRouter(view: controller);

    let cart = r.resolve(ProductCart.self)!
    let presenter = ProductListPresenter(view: controller, cart: cart);
    presenter.productRepository = r.resolve(ProductRepository.self);
    controller.presenter = presenter;

    return controller;
}

```

Luego, cuando necesitamos crear las instancias para esa pantalla, lo hacemos a través del contenedor:

```
let productController = container.resolve(ProductListViewController.self)
```

De esta manera, se tiene mayor control al momento de escribir pruebas unitarias:

```
// ProductListViewControllerTests.swift

let controller = ProductListViewController()
controller.presenter = ProductListPresenterMock()

XCTAssert(...)
```


## Ambientes y Configuración

La aplicación contiene 2 ambientes *Development* y *Staging* (se pueden agregar más) 

![environments image](/Documentation/images/environments.png)

Para cada ambiente, hay un archivo .xcconfig donde se definen las variables, por ejemplo:

```
SERVER_URL = https:/$()/api.myjson.com/bins/4bwec
APP_BUNDLE_ID = com.ilbesculpi.Cabify-Checkout.dev
APP_NAME = Cabify Checkout (DEV)
APP_CONTAINER = development
APP_ENVIRONMENT = development
APP_CURRENCY_SYMBOL = €
```

![config folder image](/Documentation/images/config_folder.png)

Y para acceder a ellas desde la aplicación, existe el archivo `Environment.swift`

```
// Environment.swift
enum Environment {

    static let serverUrl: URL = { ... }

}


// Usage
let serverUrl = Environment.serverUrl;
performApiRequest(serverUrl)
```


## Promociones

Las promociones están definidas en el archivo `Promotions.plist`

![promotions plist](/Documentation/images/promotions_plist.png)

Se pueden agregar más promociones, agregando entradas al plist. De igual manera, se pueden activar y desactivar utilizando las fechas de `start` y `end`. Si una promoción no tiene fechas, se considera activa. De lo contrario, se evalúan las fechas para determinar si al momento de la consulta, la promoción está activa.


## Persistencia

Los productos agregados al carrito de compra se guardan utilizando `Core Data`. Por lo que, al salir y volver a ingresar, los productos se mantienen en el carrito.
Una vez que la compra se concreta, el carrito es vaciado y los productos son eliminados.


## Mejoras 

- [  ] Para dispositivos más grandes (iPads), se podría utilizar un UICollectionView en lugar de UITableView para mostrar varias columnas en el listado de productos.
- [  ] Si el dispositivo no tiene conexión a internet, el listado de productos no tiene nada para mostrar. Podría utilizarse un cache para guardar la respuesta del listado de productos y mostrar estos productos aún cuando no haya conexión.
- [  ] Agregar pruebas de integración y UI

