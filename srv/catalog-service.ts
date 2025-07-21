const cds = require('@sap/cds');
const operations = require("./operations/operations");

/**
 * Implementation for CatalogService
 */
module.exports = class CatalogService extends cds.ApplicationService {

  init() {

    this.on("READ", "view_USR01", async () => {
      return await operations.getVirtualData();
    });

    this.on("READ", "view_loginlogs", async () => {
      return await operations.getUserLoginLogs();
    })

    this.on("CREATE", "view_USR05", async (req: typeof cds.Request) => {
      return await operations.insertVirtualData(req.data);
    });

    this.on("getJoinVirtualData", async () => {
      return await operations.getJoinVirtualData();
    });

    return super.init();
  }
}