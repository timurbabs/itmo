package ru.billing.client;

import ru.billing.exceptions.CatalogLoadException;
import ru.billing.stocklist.*;

public interface CatalogLoader {
    void load(ItemCatalog cat) throws CatalogLoadException;
}