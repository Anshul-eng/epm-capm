namespace anshul.db;
using { anshul.common as common } from './commons';
using { cuid, Currency } from '@sap/cds/common';

context master {
    //foreign key - ADDRESS_GUID
    entity businesspartner {
        key NODE_KEY: common.Guid;
        BP_ROLE: String(2);
        EMAIL_ADDRESS: String(125);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS: String(44);
        COMPANY_NAME: String(252);
        BP_ID: String(32);
        //COLUMN NAME - ADDRESS_GUID_NODE_KEY
        ADDRESS_GUID: Association to one address;
    };

    //check table whose primary key is NODE_key
    entity address {
        key NODE_KEY: String(32);
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING: String(128);
        COUNTRY: String(44);
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE: Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        //$self - which represent the primary key of current table
        businesspartner: Association to one businesspartner on
                            businesspartner.ADDRESS_GUID = $self;
    };

    // Removed ': cuid' because you defined a manual 'key id'
    entity employee : cuid{
        nameFirst: String(256);
        nameMiddle: String(256);
        nameLast: String(256);
        nameInitials: String(40);
        sex: common.Gender; // Added missing semicolon here
        language: String(1);
        phoneNumber: common.PhoneNumber;
        email : common.Email;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: common.AmountT;
        accountNumber: String(16);
        bankId: String(8);
        bankName: String(64);

    };

    //master data products
    entity product {
        key NODE_KEY: common.Guid;
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        SUPPLIER_GUID: Association to one master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE: Decimal(5,2);
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE: String(4);
        PRICE: Decimal(15,2);
        WIDTH: Decimal(5,2);
        DEPTH: Decimal(5,2);
        HEIGHT: Decimal(2);
        DIM_UNIT: String(2);
        DESCRIPTION: String(32);
    } 

}; // Added semicolon after context closing brace

context transaction {

    entity purchaseorder: common.Amount{
        key NODE_KEY: common.Guid;
        PO_ID: String(32);
        PARTNER_GUID : Association to master.businesspartner;
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS : String(100);
        NOTE: String(100);
        Items: Composition of many poitems on Items.PARENT_KEY = $self;

    }

    entity poitems: common.Amount{
        key NODE_KEY: common.Guid;
        PARENT_KEY : Association to purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to master.product;
    }
    
}