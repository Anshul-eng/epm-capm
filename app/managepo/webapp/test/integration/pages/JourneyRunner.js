sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"anubhav/ui/managepo/test/integration/pages/PurchaseOrderSetList",
	"anubhav/ui/managepo/test/integration/pages/PurchaseOrderSetObjectPage",
	"anubhav/ui/managepo/test/integration/pages/PurchaseOrderItemsSetObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, PurchaseOrderItemsSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('anubhav/ui/managepo') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePurchaseOrderItemsSetObjectPage: PurchaseOrderItemsSetObjectPage
        },
        async: true
    });

    return runner;
});

