package eStoreProduct.DAO;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.model.Category;
import eStoreProduct.model.Product;
import eStoreProduct.model.ProductRowMapper;
import eStoreProduct.utility.ProductStockPrice;

@Component
public class ProductDAOImp implements ProductDAO {

    @PersistenceContext
    private EntityManager entityManager;
    private final JdbcTemplate jdbcTemplate;
    private final String SQL_INSERT_PRODUCT = "insert into slam_products(prod_id, prod_title, prod_prct_id, prod_gstc_id, prod_brand, image_url, prod_desc, reorderlevel)  values(?, ?, ?, ?, ?, ?, ?, ?)";
    private final String SQL_GET_TOP_PRODID = "select prod_id from slam_products order by prod_id desc limit 1";
    private String get_products_by_catg = "select p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id and p.prod_prct_id = ?";
    private String products_query = "SELECT p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id";
    private String prdt_catg = "SELECT * FROM slam_ProductCategories";
    private String get_prd = "SELECT * FROM slam_Products WHERE prod_id = ?";
    private ProdStockDAO prodStockDAO;

    @Autowired
    public ProductDAOImp(DataSource dataSource, ProdStockDAO prodStockDAO) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        this.prodStockDAO = prodStockDAO;
    }

    @Override
    public boolean createProduct(Product p) {
        int p_id = jdbcTemplate.queryForObject(SQL_GET_TOP_PRODID, int.class);
        p_id = p_id + 1;
        System.out.println(p_id + "product_id\n");
        System.out.println(p.getProd_title() + " " + p.getProd_gstc_id() + " " + p.getProd_brand() + " "
                + p.getImage_url() + " " + p.getProd_desc() + " " + p.getReorderLevel());

        return jdbcTemplate.update(SQL_INSERT_PRODUCT, p_id, p.getProd_title(), p.getProd_prct_id(),
                p.getProd_gstc_id(), p.getProd_brand(), p.getImage_url(), p.getProd_desc(), p.getReorderLevel()) > 0;
    }

    public List<ProductStockPrice> getProductsByCategory(Integer category_id) {
    	
    	System.out.println("in pdaoimp cid   "+category_id);
    	List<ProductStockPrice> p=jdbcTemplate.query(get_products_by_catg, new ProductRowMapper(prodStockDAO), category_id);
    	for(ProductStockPrice ps:p)
    	{
    		System.out.println("for loop      "+ps);
    	}
    	return p;
    }

    public List<ProductStockPrice> getAllProducts() {
        return jdbcTemplate.query(products_query, new ProductRowMapper(prodStockDAO));
    }

    public List<Category> getAllCategories() {
        return jdbcTemplate.query(prdt_catg, new CategoryRowMapper());
    }

    public ProductStockPrice getProductById(Integer productId) {
        List<ProductStockPrice> products = jdbcTemplate.query(get_prd, new ProductRowMapper(prodStockDAO), productId);
        return products.isEmpty() ? null : products.get(0);
    }

    @Override
    public List<String> getAllProductCategories() {
        // TODO Auto-generated method stub
        return null;
    }

}
