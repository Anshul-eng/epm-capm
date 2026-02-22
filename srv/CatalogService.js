const cds = require('@sap/cds')
const req = require('express/lib/request')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { EmployeeSet, ProductSet, BusinessPartnerSet, AddressSet, PurchaseOrderSet, PurchaseOrderItemsSet } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], EmployeeSet, async (req) => {
    console.log('Before CREATE/UPDATE EmployeeSet', req.data)
    // get the employee salary info
    let salaryAmount = parseFloat(req.data.salaryAmount)
    if(salaryAmount > 1000000){
      //Contaminate the incoming request, so CAPM will know that somthing gone wrong in your green box
      req.error(500, "Hey Amigo! check the salary none of employee get a millon");
      
    }
  })
  this.after ('READ', EmployeeSet, async (employeeSet, req) => {
    console.log('After READ EmployeeSet', employeeSet)
  })
  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    console.log("AFTER READ TRIGGERED");
    console.log('After READ ProductSet', productSet)

   
  })
  this.before (['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
    console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
  })
  this.after ('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
    console.log('After READ BusinessPartnerSet', businessPartnerSet)
  })
  this.before (['CREATE', 'UPDATE'], AddressSet, async (req) => {
    console.log('Before CREATE/UPDATE AddressSet', req.data)
  })
  this.after ('READ', AddressSet, async (addressSet, req) => {
    console.log('After READ AddressSet', addressSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
    console.log('After READ PurchaseOrderSet', purchaseOrderSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderItemsSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderItemsSet', req.data)
  })
  this.after ('READ', PurchaseOrderItemsSet, async (purchaseOrderItemsSet, req) => {
    console.log('After READ PurchaseOrderItemsSet', purchaseOrderItemsSet)
  })

  ///Implementation for order defaults
  this.on('getDefaultValue', async (req,res) => {
    return {
      OVERALL_STATUS: 'N',
      LIFECYCLE_STATUS : 'N'
    }
  });

  //generic handler to support my function implemetation - always return data, GET
  this.on('getLargestOrder',async(req,res) => {
    try {

        const tx = cds.tx(req);

        //use CDS QL to make call to db - select * up to 3 rows from POs Order by GROSS_AMOUNT descende 
        const reply = await tx.read(PurchaseOrderSet).orderBy({
          'GROSS_AMOUNT' : 'desc'
        }).limit(3);

        return reply;

    } catch (error){
    req.error(500,"Some error occured : " + cds.error.toString());
    }
  });



  return super.init()
}}
