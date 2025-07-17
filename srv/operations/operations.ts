const cds = require("@sap/cds");
const HelperClass = require("../lib/helper");
const constants = require("../constants/constant");
const sql = require("../sql/sql");
const logger = cds.log("OperationsClass");

module.exports = class OperationsClass {

    // Regular SELECT statement
    static async getVirtualData() {
        const where = {
            bname: "BATCH_USER"
        };
        const columns = [
            "*", "profiles.name", "profiles.role", "profiles.department"
        ]
        const result = await HelperClass.fnRead(sql.TABLES.V_USR02, where, columns);
        logger.info(JSON.stringify(result));
        return result;
    }

    // SELECT with JOIN
    static async getUserLoginLogs() {
        const result = await cds.run(sql.QUERIES.PROFILES_JOIN_LOGINLOGS, ["Admin"])
        logger.info(JSON.stringify(result));
        return result;
    }
}