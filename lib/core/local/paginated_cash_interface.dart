part of "hive_service_impl.dart";


abstract interface class IPaginatedCache<T> {
  Future<void> getPaginated(String cacheKey);
  Future<void> cachePage(List<T> items, {String? cacheKey});
  Future<List<T>> getCachedPage({String? cacheKey});
}

class CategoriesPaginatedCache<CategoryModel>
    extends IPaginatedCache<CategoryModel> {
  final HiveServiceImpl _hiveServiceImpl;
  CategoriesPaginatedCache(this._hiveServiceImpl);
  @override
  Future<void> cachePage(List<CategoryModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "categories$cacheKey");

  @override
  Future<List<CategoryModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<CategoryModel>(
        cacheKey: "categories$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "categories$cacheKey");
}

class GetCatoryItemsPaginatedCache<GetProductByCatagoryModel>
    extends IPaginatedCache<GetProductByCatagoryModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetCatoryItemsPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetProductByCatagoryModel> items, {
    String? cacheKey,
  }) => _hiveServiceImpl._cachePage(items, cacheKey: "catagory_items$cacheKey");

  @override
  Future<List<GetProductByCatagoryModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetProductByCatagoryModel>(
        cacheKey: "catagory_items$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "search$cacheKey");
}

//active supplier
class GetactivesupplierPaginatedCache<GetActiveSupplierProduct>
    extends IPaginatedCache<GetActiveSupplierProduct> {
  final HiveServiceImpl _hiveServiceImpl;

  GetactivesupplierPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetActiveSupplierProduct> items, {
    String? cacheKey,
  }) => _hiveServiceImpl._cachePage(
    items,
    cacheKey: "active_supplier_items$cacheKey",
  );

  @override
  Future<List<GetActiveSupplierProduct>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetActiveSupplierProduct>(
        cacheKey: "active_supplier_items$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "search$cacheKey");
}

//offer supplier
class GetOfferPaginatedCache<GetActiveSupplierProduct>
    extends IPaginatedCache<GetActiveSupplierProduct> {
  final HiveServiceImpl _hiveServiceImpl;

  GetOfferPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetActiveSupplierProduct> items, {
    String? cacheKey,
  }) => _hiveServiceImpl._cachePage(items, cacheKey: "offer_items$cacheKey");

  @override
  Future<List<GetActiveSupplierProduct>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetActiveSupplierProduct>(
        cacheKey: "offer_items$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "search$cacheKey");
}

//not active
class GetNotactivePaginatedCache<GetActiveSupplierProduct>
    extends IPaginatedCache<GetActiveSupplierProduct> {
  final HiveServiceImpl _hiveServiceImpl;

  GetNotactivePaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetActiveSupplierProduct> items, {
    String? cacheKey,
  }) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "notactive_items$cacheKey");

  @override
  Future<List<GetActiveSupplierProduct>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetActiveSupplierProduct>(
        cacheKey: "notactive_items$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "search$cacheKey");
}

//not availailble
class GetUnavailblePaginatedCache<GetActiveSupplierProduct>
    extends IPaginatedCache<GetActiveSupplierProduct> {
  final HiveServiceImpl _hiveServiceImpl;

  GetUnavailblePaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetActiveSupplierProduct> items, {
    String? cacheKey,
  }) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "notactive_items$cacheKey");

  @override
  Future<List<GetActiveSupplierProduct>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetActiveSupplierProduct>(
        cacheKey: "notactive_items$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "search$cacheKey");
}

//pending supplier
class GetPendingPaginatedCache<OrderModel> extends IPaginatedCache<OrderModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetPendingPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<OrderModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "pending_items$cacheKey");

  @override
  Future<List<OrderModel>> getCachedPage({String? cacheKey}) => _hiveServiceImpl
      ._getCachedPage<OrderModel>(cacheKey: "notactive_items$cacheKey");

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "pending_items$cacheKey");
}

class GetconfermedPaginatedCache<OrderModel>
    extends IPaginatedCache<OrderModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetconfermedPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<OrderModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "confermed_items$cacheKey");

  @override
  Future<List<OrderModel>> getCachedPage({String? cacheKey}) => _hiveServiceImpl
      ._getCachedPage<OrderModel>(cacheKey: "confermed_items$cacheKey");

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "confermed_items$cacheKey");
}

class GetShipperPaginatedCache<OrderModel> extends IPaginatedCache<OrderModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetShipperPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<OrderModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "shipper_items$cacheKey");

  @override
  Future<List<OrderModel>> getCachedPage({String? cacheKey}) => _hiveServiceImpl
      ._getCachedPage<OrderModel>(cacheKey: "shipper_items$cacheKey");

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "shipper_items$cacheKey");
}

class GetDeliveryPaginatedCache<OrderModel>
    extends IPaginatedCache<OrderModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetDeliveryPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<OrderModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "delivery_items$cacheKey");

  @override
  Future<List<OrderModel>> getCachedPage({String? cacheKey}) => _hiveServiceImpl
      ._getCachedPage<OrderModel>(cacheKey: "delivery_items$cacheKey");

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "delivery_items$cacheKey");
}
//getsupplierpenalities

class GetSupplierPenalitiesPaginatedCache<GetSupplierPenalitiesModel>
    extends IPaginatedCache<GetSupplierPenalitiesModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetSupplierPenalitiesPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetSupplierPenalitiesModel> items, {
    String? cacheKey,
  }) => _hiveServiceImpl._cachePage(
    items,
    cacheKey: "supplierpenalities$cacheKey",
  );

  @override
  Future<List<GetSupplierPenalitiesModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetSupplierPenalitiesModel>(
        cacheKey: "supplierpenalities$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) => _hiveServiceImpl
      ._clearCachedPage(cacheKey: "supplierpenalities$cacheKey");
}

//get supllierstatment
class GetSupplierStatmentPaginatedCache<GetSupplierstatmentModel>
    extends IPaginatedCache<GetSupplierstatmentModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetSupplierStatmentPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetSupplierstatmentModel> items, {
    String? cacheKey,
  }) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "supplierstatment$cacheKey");

  @override
  Future<List<GetSupplierstatmentModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetSupplierstatmentModel>(
        cacheKey: "supplierstatment$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "supplierstatment$cacheKey");
}

//get return order
class GetReturnOrderPaginatedCache<ReturnedOrderModel>
    extends IPaginatedCache<ReturnedOrderModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetReturnOrderPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<ReturnedOrderModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "returnorder$cacheKey");

  @override
  Future<List<ReturnedOrderModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<ReturnedOrderModel>(
        cacheKey: "returnorder$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "returnorder$cacheKey");
}

class GetStationsPaginatedCache<StationsModel>
    extends IPaginatedCache<StationsModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetStationsPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(List<StationsModel> items, {String? cacheKey}) =>
      _hiveServiceImpl._cachePage(items, cacheKey: "returnorder$cacheKey");

  @override
  Future<List<StationsModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<StationsModel>(
        cacheKey: "returnorder$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "returnorder$cacheKey");
}

class GetMyStationsPaginatedCache<GetMyDeliveryStationModel>
    extends IPaginatedCache<GetMyDeliveryStationModel> {
  final HiveServiceImpl _hiveServiceImpl;

  GetMyStationsPaginatedCache(this._hiveServiceImpl);

  @override
  Future<void> cachePage(
    List<GetMyDeliveryStationModel> items, {
    String? cacheKey,
  }) => _hiveServiceImpl._cachePage(items, cacheKey: "returnorder$cacheKey");

  @override
  Future<List<GetMyDeliveryStationModel>> getCachedPage({String? cacheKey}) =>
      _hiveServiceImpl._getCachedPage<GetMyDeliveryStationModel>(
        cacheKey: "returnorder$cacheKey",
      );

  @override
  Future<void> getPaginated(String cacheKey) =>
      _hiveServiceImpl._clearCachedPage(cacheKey: "returnorder$cacheKey");
}