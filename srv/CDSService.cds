using { anshul.cds } from '../db/CDSViews';

service CDSService @(path: 'CDSService'){

    //select * from view
    entity ProductSet as projection on cds.CDSViews.ProductView{
        *,
        //never be persisted in db
        virtual soldCount : Int16 
    };

    entity ItemsSet as projection on cds.CDSViews.ItemView;

}

