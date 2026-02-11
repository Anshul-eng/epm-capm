//consume reference of my db table

using{ anshul.db.master , anshul.db.transaction} from '../db/datamodel';

service CatalogService @(path: 'CatalogService'){
    
    //Exposing entities for curd operation
    entity EmployeeSet as projection on master.employee;
    entity PurchaseOrderSet as projection on transaction.purchaseorder;
    entity PurchaseOrderItemsSet as projection on transaction.poitems;

}