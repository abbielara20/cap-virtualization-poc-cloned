using my.bookshop as my from '../db/schema';

service CatalogService @(path: '/catalog') {
    @readonly
    entity Books as projection on my.Books;
    function getData() returns String;

}
