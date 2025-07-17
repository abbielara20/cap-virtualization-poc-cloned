const cds = require('@sap/cds');
const operations = require("./operations/operations");

/**
 * Implementation for CatalogService
 */
module.exports = class CatalogService extends cds.ApplicationService {

  init() {

    this.on("getVirtualData", async () => {
      return await operations.getVirtualData();
    });

    this.on("READ", "view_loginlogs", async() => {
      return await operations.getUserLoginLogs();
    })

    return super.init();
  }
}