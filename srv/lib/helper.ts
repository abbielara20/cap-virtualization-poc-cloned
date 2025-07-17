const cds = require('@sap/cds');
const { TextBundle } = require("@sap/textbundle");
const logger = cds.log("HelperClass");

module.exports = class HelperClass {
    /**
   * Insert records in bulk
   * @param {string} entity - table name
   * @param {array} entries - record of columns and values
   * @returns result of the query / error encountered
   */
    static async fnCreate<T>(entity: string, entries: T[]): Promise<unknown> {
        const tx = cds.tx();
        try {
            const query = INSERT.into(entity).entries(entries);
            const result = await tx.run(query).then(tx.commit, tx.rollback);
            return result;
        } catch (error) {
            logger.error("Error encountered in inserting data:", error);
            throw error;
        }
    }

    /**
     * Read records with or without conditions
     * @param {object} entity - table name
     * @param {array} columns - columns to be retrieved
     * @param {object} where - condition in which record to be retrieved
     * @param {array} having - condition in which record to be retrieved
     * @param {array} groupBy - groups the records
     * @param {array} orderBy - order the records in asc or desc order
     * @returns result of the query / error encountered
     */
    static async fnRead(
        entity: string,
        where: Record<string, any> = {},
        columns: string[] = [],
        options?: {
            having: string[],
            groupBy: string[],
            orderBy: string[]
        }
    ): Promise<unknown> {
        try {
            let query = SELECT
                .from(entity)
                .columns(...columns)
                .where(where);
            if (options?.having) query = query.having(options.having);
            if (options?.groupBy) query = query.groupBy(...options.groupBy);
            if (options?.orderBy) query = query.orderBy(...options.orderBy);
            const result = await cds.run(query);
            return result;
        } catch (error) {
            logger.error("Error encountered in reading data:", error);
            throw error;
        }
    }

    /**
     * Update a single entry record that matches the key field/s
     * @param {object} entity - table name
     * @param {object} where - condition in which record to be updated
     * @param {object} entries - record of columns and values
     * @returns result of the query / error encountered
     */
    static async fnUpdate(entity: string, where: Record<string, any>, entries: Record<string, any>): Promise<unknown> {
        const tx = cds.tx();
        try {
            const query = UPDATE(entity).set(entries).where(where);
            const result = await tx.run(query).then(tx.commit, tx.rollback);
            return result;
        } catch (error) {
            logger.error("Error encountered in updating data:", error);
            throw error;
        }
    }

    /**
     * Insert records in bulk if values of the key field/s does not exists.
     * Otherwise, update records in bulk.
     * @param {string} entity - table name
     * @param {array} entries - record of columns and values
     * @returns result of the query / error encountered
     */
    static async fnUpsert<T>(entity: string, entries: T[]): Promise<unknown> {
        try {
            const tx = cds.tx();
            const query = UPSERT.into(entity).entries(entries);
            const result = await tx.run(query).then(tx.commit, tx.rollback);
            return result;
        } catch (error) {
            logger.error(
                "Error encountered in updating or inserting data:",
                error
            );
            throw error;
        }
    }

    /**
     * Delete records based on the condition
     * @param {string} entity - table name
     * @param {object} where - condition in which record to be deleted
     * @returns result of the query / error encountered
     */
    static async fnDelete(entity: string, where: Record<string, any>): Promise<unknown> {
        try {
            const tx = cds.tx();
            const query = DELETE.from(entity).where(where);
            const result = await tx.run(query).then(tx.commit, tx.rollback);
            return result;
        } catch (error) {
            logger.error("Error encountered in deleting data:", error);
            throw error;
        }
    }

    /**
       * Retrieves the localized strings from i18n
       * @param {string} locale - local of the user logged in
       * @returns {object} TextBundle - TextBundle
       */
    static fnGetTextBundle(locale: string): typeof TextBundle {
        return new TextBundle("../i18n/i18n", locale);
    }
}