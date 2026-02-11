namespace anshul.common;

using { Currency } from '@sap/cds/common'; // Added semicolon

// Reusable type 
type Guid : String(32);

// Domain fix value M-male, F-Female
type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}; // Added semicolon

// Reference field for quantity and currency
// Renamed to AmountT to avoid conflict with Aspect name
type AmountT : Decimal(10,2) @(
    Semantics.amount.currencyCode: 'CURRENCY_code'
);

// Custom structure (Aspect)
aspect Amount {
    CURRENCY     : Currency;
    GROSS_AMOUNT : AmountT; // Points to the type defined above
    NET_AMOUNT: AmountT;
    TAX_AMOUNT: AmountT;
}

type PhoneNumber : String(30) @assert.format : '^[6-9]\d{9}$';
type Email : String(250) //@assert.format : '^[a-zA-Z0-9._%+-]+\.[a-zA-Z]{2,}$';
