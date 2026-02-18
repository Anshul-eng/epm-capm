//consume reference of my db table

using{ anshul.db.master , anshul.db.transaction} from '../db/datamodel';

service CatalogService @(path: 'CatalogService'){
    
    //Exposing entities for curd operation
    entity EmployeeSet as projection on master.employee;
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity PurchaseOrderSet as projection on transaction.purchaseorder;
    entity PurchaseOrderItemsSet as projection on transaction.poitems;

    //non instance bound because they are not connected to any entity
    function getLargestOrder() returns array of  PurchaseOrderSet;
    function getDefaultValue() returns PurchaseOrderSet;

}