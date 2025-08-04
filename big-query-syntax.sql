-- Membuat Tabel Baru Setelah dilakukan penggabungan data
CREATE OR REPLACE TABLE skillful-signer-467214-n0.kimia_farma.kf_final_dataset AS

-- Memilih kolom untuk target analisa
SELECT
  ft.transaction_id,
  ft.date,
  ft.branch_id, 
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  ft.product_id,
  pr.product_name,
  ft.price,
  ft.discount_percentage,
  
CASE
    WHEN ft.price <= 50000 THEN 0.10
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
    ELSE 0.3
END AS persentase_gross_laba,

	(ft.price - (ft.price * ft.discount_percentage)) AS nett_sales,
	(ft.price * 
		(CASE
			WHEN ft.price <= 50000 THEN 0.10
			WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
			WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
			WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
			ELSE 0.3
		END)
    ) AS nett_profit,
  ft.rating AS rating_transaksi

-- Mengambil dan menggabungkan sumber data yang tersedia  
FROM skillful-signer-467214-n0.kimia_farma.kf_final_transaction AS ft
JOIN skillful-signer-467214-n0.kimia_farma.kf_kantor_cabang AS kc
    ON ft.branch_id = kc.branch_id
JOIN skillful-signer-467214-n0.kimia_farma.kf_product AS pr
    ON ft.product_id = pr.product_id;
