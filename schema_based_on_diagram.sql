CREATE TABLE medical_histories (
id SERIAL PRIMARY KEY,
admitted_at DATE,
patient_id INTEGER,
status VARCHAR(255)
);


CREATE TABLE patients (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
date_of_birth DATE
);


CREATE TABLE treatments (
id SERIAL PRIMARY KEY,
type VARCHAR(255),
name VARCHAR(255)
);

CREATE TABLE invoice_items (
id SERIAL PRIMARY KEY,
unit_price DECIMAL(10,2),
quantity INTEGER,
total_price DECIMAL(10,2),
invoice_id INTEGER,
treatment_id INTEGER
);

CREATE TABLE invoices (
id SERIAL PRIMARY KEY,
total_amount DECIMAL(10,2),
generated_at timestamp DEFAULT CURRENT_TIMESTAMP,
payed_at timestamp DEFAULT CURRENT_TIMESTAMP,
medical_history_id INTEGER
);

CREATE TABLE medical_history_treatment (
medical_history_id INTEGER REFERENCES medical_histories(id),
treatment_id INTEGER REFERENCES treatments (id),
PRIMARY KEY (medical_history_id, treatment_id));

ALTER TABLE invoices
ADD CONSTRAINT fk_medical_history_id
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE medical_histories
ADD CONSTRAINT fk_medical_histories_patients
FOREIGN KEY (patient_id)
REFERENCES patients (id);

ALTER TABLE invoice_items
ADD CONSTRAINT FK_invoices_items_invoices
FOREIGN KEY (invoice_id)
REFERENCES invoices (id);

ALTER TABLE invoice_items
ADD CONSTRAINT FK_invoice_items_treatments
FOREIGN KEY (treatment_id)
REFERENCES treatments (id);
