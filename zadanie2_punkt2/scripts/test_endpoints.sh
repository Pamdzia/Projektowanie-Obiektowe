#!/bin/bash

HOST=http://localhost:8000
ENDPOINT=product

success_count=0
error_count=0

#GET (odczyt)
echo "Pobieranie listy produktów..."
response=$(curl -X GET "${HOST}/${ENDPOINT}/" -w "%{http_code}" -o /dev/null)
echo "Kod odpowiedzi: $response"

if [ $? -eq 0 ]; then
    echo "GET ${HOST}/${ENDPOINT}/ - sukces"
    ((success_count++))
else
    echo "GET ${HOST}/${ENDPOINT}/ - błąd"
    ((error_count++))
fi

PRODUCT_ID=1

#GET (odczyt szczegółów produktu)
echo "Pobieranie szczegółów produktu o ID ${PRODUCT_ID}..."
response=$(curl -X GET "${HOST}/${ENDPOINT}/${PRODUCT_ID}" -w "%{http_code}" -o /dev/null)
echo "GET ${HOST}/${ENDPOINT}/${PRODUCT_ID} - Kod odpowiedzi: $response"

if [ $? -eq 0 ]; then
    echo "GET ${HOST}/${ENDPOINT}/${PRODUCT_ID} - sukces"
    ((success_count++))
else
    echo "GET ${HOST}/${ENDPOINT}/${PRODUCT_ID} - błąd"
    ((error_count++))
fi

# POST (tworzenie nowego produktu)
echo "Tworzenie nowego produktu..."
response=$(curl -X POST "${HOST}/${ENDPOINT}/new" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "name=TestProduct&price=9.99&description=This is a test product" -w "%{http_code}" -o /dev/null)
echo "POST ${HOST}/${ENDPOINT}/new - Kod odpowiedzi: $response"

if [ $? -eq 0 ]; then
    echo "POST ${HOST}/${ENDPOINT}/new - sukces"
    ((success_count++))
else
    echo "POST ${HOST}/${ENDPOINT}/new - błąd"
    ((error_count++))
fi

# PUT (aktualizacja produktu)
echo "Aktualizowanie produktu o ID ${PRODUCT_ID}..."
response=$(curl -X POST "${HOST}/${ENDPOINT}/${PRODUCT_ID}/edit" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "_method=PUT&name=UpdatedProduct&price=14.99&description=Updated description" -w "%{http_code}" -o /dev/null)
echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID}/edit - Kod odpowiedzi: $response"

if [ $? -eq 0 ]; then
    echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID}/edit - sukces"
    ((success_count++))
else
    echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID}/edit- błąd"
    ((error_count++))
fi

# DELETE (usuwanie produktu)
echo "Usuwanie produktu o ID ${PRODUCT_ID}..."
response=$(curl -X POST "${HOST}/${ENDPOINT}/${PRODUCT_ID}" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "_method=DELETE" -w "%{http_code}" -o /dev/null)
echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID} - Kod odpowiedzi: $response"

if [ $? -eq 0 ]; then
    echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID} - sukces"
    ((success_count++))
else
    echo "POST ${HOST}/${ENDPOINT}/${PRODUCT_ID}- błąd"
    ((error_count++))
fi

#podsumowanie testów
echo "Testy zakończone."
echo "Sukcesy: $success_count"
echo "Błędy: $error_count"