using { anshul.cds } from '../db/CDSViews';

service CDSService @(path: 'CDSService'){

    entity ProductSet as projection on cds.CDSViews.ProductView;
    entity ItemsSet as projection on cds.CDSViews.ItemView;

}

