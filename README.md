# data-cleaning-orders
Projekt SQL czyszczenia danych zamówień (PostgreSQL)

Ten projekt przedstawia podstawpwe sposób czyszczenia nieuporządkowanych danych z zamówień klientów przy użyciu SQL w PostgreSQL. 
W danych wejściowych występowały błędy typowe dla danych operacyjnych: 
-różne formaty dat, 
-tekstowe wartości liczbowe, 
-brakujące dane oraz niespójne statusy i ceny.

## Zakres czyszczenia:
- normalizacja imion i nazwisk klientów (usuwanie "Pan", "Pani", poprawa wielkości liter),
- konwersja różnych formatów dat na jeden (YYYY-MM-DD),
- zamiana wartości tekstowych (np. "two", "-1") na liczby całkowite,
- czyszczenie statusów (np. "del." → "delivered"),
- poprawienie wartości cenowych.

## Technologie
- PostgreSQL
- CASE, REGEXP_REPLACE, TO_DATE, CAST, INITCAP, ILIKE
- CREATE VIEW

## Pliki projektu
- clean_orders.sql – kod czyszczący dane
- clean_orders_view.sql – widok SQL z gotowymi danymi
- README.md – opis projektu
- raw_data.csv – (opcjonalnie) dane źródłowe

## Efekt
Dane wyczyszczone zostały zapisane jako widok 'clean_orders', gotowy do analizy.

### Przykład: dane przed czyszczeniem
## Efekt po czyszczeniu danych

Poniżej przykład widoku 'clean_orders' z oczyszczonymi danymi:

![clean_orders](clean_orders_preview.png)

### Przykład zastosowania widoku
 
SELECT * 
FROM clean_orders 
  WHERE quantity >= '2';

## Uwaga dotycząca danych

Wszystkie dane użyte w tym projekcie są całkowicie fikcyjne.  
Zostały wymyślone na potrzeby nauki i nie zawierają żadnych informacji wrażliwych ani danych osobowych.

## Autor
Katarzyna Wróblewska
katarzynawroblewska.data@gmail.com
