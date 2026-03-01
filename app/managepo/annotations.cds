using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(

    //Add fields to the screen for filtering the data
    UI.SelectionFields: [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    //Add the columns to the table data
    UI.LineItem       : [
        {
            $Type         : 'UI.DataField',
            Value         : PO_ID,
            @UI.Importance: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label : 'boost',
            Inline: true,
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: Spiderman
        },
    ],

    UI.HeaderInfo:{
        // title of the table - first screen
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        //Second screen title section
        Title : {Value : PO_ID},
        Description: {Value : PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://media.licdn.com/dms/image/v2/C4D0BAQEADNH5e7u7AA/company-logo_200_200/company-logo_200_200/0/1630495746155?e=2147483647&v=beta&t=C0mpGHQBe1jfTxx8oubZgfmrh0PZTHQ5jdRsgtEbOVw'
    },

    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets : [
                {
                    Label : 'Basic info',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.Identification',
                },
                {
                    Label : 'Pricing Detail',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#Spiderman',
                },
                {
                    Label : 'Additional Data',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#Superman',
                },
            ]
        },
        {
            Label : 'Items',
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem'
        },
    ],
    //default block which is always and always ONE - Identification
    //contains the group of fields
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value :  PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : NOTE,
        },
    ],

    //FieldGroup block that can be multiple and have many fields inside
    UI.FieldGroup #Spiderman:  {  
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label: 'Tax Amount',
                Value : TAX_AMOUNT,
            },
        ],
    },

    //Field Group for status data
    UI.FieldGroup #Superman: { 
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
        ],
    }
);

annotate service.PurchaseItemsSet with @(
    UI.HeaderInfo: { 
        TypeName : 'PO Item',
        TypeNamePlural : 'Purchase Order Item',
        Title : { Value : PO_ITEM_POS },
        Description : {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Detail',
            Target : '@UI.Identification',

        }
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
         {
            Label : 'Tax Amount',
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        }
    ]
);

//annotate a field to get its meaningful text
annotate service.PurchaseOrderSet with {
    @Common.Text: overallStatus
    OVERALL_STATUS;
    @Common.Text: NOTE
    PO_ID;
    @Common.Text: PARTNER_GUID.COMPANY_NAME
    @ValueList.entity : service.BusinessPartnerSet
    //@Common : { TextArrangement : #TextOnly, }
    PARTNER_GUID;  
}

//annotate a field to get its meaningful text
annotate service.PurchaseItemsSet with {
    @Common.Text: PRODUCT_GUID.DESCRIPTION
    //@UI.Hidden: true
    //@Common : { TextArrangement : #TextOnly } 
    @ValueList.entity : service.ProductSet
    PRODUCT_GUID;
};

// Design Value help in CApm for partner Guid and product Guid
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @( 
   UI.Identification:[
    {
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    },
   ]
);

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
    ]
) ;



