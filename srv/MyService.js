const cds = require('@sap/cds')

module.exports = class MyService extends cds.ApplicationService { init() {



  this.on ('anshul', async (req) => {
    console.log('On anshul', req.data)
    let myName = req.data.name;
    return `Welcome to CAP Service, Hello ${myName}!! How are you`;
  })

  return super.init()
}}
