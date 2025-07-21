const cds = require("@sap/cds");
const HelperClass = require("../lib/helper");
const constants = require("../constants/constant");
const sql = require("../sql/sql");
const logger = cds.log("OperationsClass");

module.exports = class OperationsClass {

    // Using READ statement with association for Virtual and HANA tables
    // Filter from multiple tables
    static async getVirtualData(): Promise<unknown> {
        const where = {
            ["assoc_usr02.class"]: "TEST_USER",
            ["assoc_usr04.modbe"]: "TRIPATHIA",
            ["assoc_usr05.parva"]: "ZTMSHEET",
            ["profiles.active"]: true
        };
        const columns = [
            "*", "assoc_usr02.pwdchgdate", "assoc_usr04.modda", "assoc_usr04.modti", "assoc_usr05.parva", "profiles.role"
        ]
        const result = await HelperClass.fnRead(sql.TABLES.V_USR01, where, columns);
        logger.info(JSON.stringify(result));
        return result;
    }

    // Using READ prepared statement with JOIN for HANA tables
    static async getUserLoginLogs() {
        const result = await cds.run(sql.QUERIES.PROFILES_JOIN_LOGINLOGS, ["Admin"])
        logger.info(JSON.stringify(result));
        return result;
    }

    // Using READ prepared statement with JOIN for Virtual and HANA tables
    // Filter from multiple tables
    static async getJoinVirtualData() {
        const result = await cds.run(sql.QUERIES.VIRTUAL_JOIN_HANA, ["TEST_USER", "TRIPATHIA", "ZTMSHEET", true])
        logger.info(JSON.stringify(result));
        return result;
    }

    // Using WRITE statement for Virtual table
    // Expect error
    static async insertVirtualData<T>(data: T[]): Promise<unknown> {
        const result = await HelperClass.fnCreate(sql.TABLES.V_USR05, [data])
        logger.info(JSON.stringify(result));
        return result;
    }
}