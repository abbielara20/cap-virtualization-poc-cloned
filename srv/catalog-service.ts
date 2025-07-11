import type { Books } from '#cds-models/my/bookshop';
import cds from '@sap/cds';
const logger = cds.log("CatService");

/**
 * Implementation for CatalogService
 */
export default class CatalogService extends cds.ApplicationService {

  async init() {

    // Register event handlers
    this.on('READ', 'Books', this.onReadBooks);
    this.on('READ', 'getData', this.getData);

    return super.init();
  }

  private async getData() {
    const books = await cds.run(SELECT.from(cds.entities.Books));
    const authors = await cds.run(SELECT.from(cds.entities.Authors))
    const allData = books.concat(authors);
    logger.info("getDataLog");
    logger.info(JSON.stringify(allData))
    logger.info("log local");
    return JSON.stringify(allData);
  }

  /**
   * Handler for reading Books
   */
  private async onReadBooks(req: any) {
    // Since this is @readonly, we can add custom logic here
    // For example, add logging, filtering, or enrichment

    // Call the default handler (which will query the database)
    const books = await cds.run(req.query);

    // Optional: Add custom logic to enrich the data
    // books.forEach((book: Books) => {
    //   // Add computed fields, format data, etc.
    // });

    return books;
  }

  /**
   * Optional: Add custom business logic
   * Example: Get featured books
   */
  async getFeaturedBooks(): Promise<Books[]> {
    const { Books } = this.entities;

    return await cds.run(
      SELECT.from(Books).where({ stock: { '>=': 10 } }).limit(5)
    );
  }
}

// Alternative function-based implementation:
/*
export = (srv: Service) => {
  
  srv.on('READ', 'Books', async (req) => {
    console.log('Reading books from catalog service');
    
    // Default behavior for @readonly
    return cds.run(req.query);
  });

  // Add custom actions/functions if needed
  srv.on('getFeaturedBooks', async () => {
    const { Books } = srv.entities;
    return await cds.run(
      SELECT.from(Books).where({ stock: { '>=': 10 } }).limit(5)
    );
  });
  
};
*/