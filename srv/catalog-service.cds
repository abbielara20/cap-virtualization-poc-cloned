using {
    V_USR02,
    profiles,
    login_logs
} from '../db/schema';

service CatalogService @(path: '/catalog') {

    entity view_USR02 as projection on V_USR02;
    entity view_profiles as projection on profiles;
    entity view_loginlogs as projection on login_logs;

    function getVirtualData() returns String;
}
