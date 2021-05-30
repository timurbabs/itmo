import com.javatunes.util.ItemDAO;
import com.javatunes.util.MusicItem;
import org.apache.derby.client.am.Connection;
import org.apache.derby.client.am.DatabaseMetaData;

import java.math.BigDecimal;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

public class ItemDAOMain {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Properties props = new Properties();
        props.setProperty("user", "GUEST");
        conn = (Connection) DriverManager.getConnection("jdbc:derby://localhost:1527/JavaTunesDB", props);
        MusicItem musicItem;
        ItemDAO itemDAO = new ItemDAO(conn);
        musicItem = itemDAO.searchById(1L);
        System.out.println(musicItem.toString());
        musicItem = itemDAO.searchById(100L);
        if (musicItem != null) {
            System.out.println(musicItem.toString());
        }

        var coll1 = itemDAO.searchByKeyword("of").size();
        System.out.println(coll1);
        var coll2 = itemDAO.searchByKeyword("Gay").size();
        System.out.println(coll2);

        //test update
        MusicItem test = new MusicItem();
        test.setArtist("Nirvana");
        test.setTitle("The man who sold the world");
        test.setListPrice(new BigDecimal("123.24"));
        test.setPrice(new BigDecimal("12.32"));
        test.setReleaseDate(new Date());
        itemDAO.create(test);
        var returnme = (ArrayList<MusicItem>)itemDAO.searchByKeyword("sold");
        for (int i = 0; i < returnme.size(); i++) {
            System.out.println(returnme.get(i).toString());
        }
        conn.close();
    }
}
