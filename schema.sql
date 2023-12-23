-- Represent genes
CREATE TABLE "genes" (
    "id" INTEGER,
    "name(symbol)" VARCHAR(50) NOT NULL,
    "entrez_id" INTEGER UNIQUE NOT NULL,
    "chromosome" VARCHAR(10), -- location of the gene
    "ontology" TEXT, -- GO annotations (function of the genes and gene products)
    "source" TEXT NOT NULL, -- data source, publication
    PRIMARY KEY("id")
);

-- Represent mature microRNAs
CREATE TABLE "miRNAs" (
    "id" INTEGER,
    "name" VARCHAR(30) NOT NULL,
    "family" VARCHAR(20) NOT NULL, -- group of miRNAs that derive from the common ancestor
    "seed" VARCHAR(10) NOT NULL, -- seed region of the mature miRNA
    "5p_accession" VARCHAR(30), -- unique and fixed identifier assigned to a sequence record of a miRNA
    "3p_accession" VARCHAR(30),
    "target_gene_id" INT,
    "chromosome" VARCHAR(10),
    "source" VARCHAR(50) NOT NULL, -- data source, publication
    PRIMARY KEY("id"),
    FOREIGN KEY("target_gene_id") REFERENCES "Genes"("id")
);

-- Represent diseases and the affected system
CREATE TABLE "diseases" (
    "id" INTEGER,
    "name" VARCHAR(100) NOT NULL,
    "affected_system" TEXT, -- cardiology, endocrinology, pulmology, ...
    "description" TEXT,
    PRIMARY KEY("id")
);

-- Represent drugs and their function
CREATE TABLE "drugs" (
    "id" INTEGER,
    "name" VARCHAR(100) NOT NULL,
    "type" VARCHAR(50), -- for example antibiotic, analgesic, antihypertensive
    "administration" VARCHAR(50), -- route of administration (oral, intravenous, intramusculus, topical, ...)
    "disease_id" INT,
    "target_gene_id" INT,
    "target_miRNA_id" INT,
    PRIMARY KEY("id"),
    FOREIGN KEY("disease_id") REFERENCES "diseases"("id"),
    FOREIGN KEY("target_gene_id") REFERENCES "genes"("id"),
    FOREIGN KEY("target_miRNA_id") REFERENCES "miRNAs"("id")
);

-- Represent interactions between all of the above tables
CREATE TABLE "interactions" (
    "id" INTEGER,
    "miRNA_id" INT,
    "gene_id" INT,
    "disease_id" INT,
    "drug_id" INT,
    "type" VARCHAR(50), -- for example inhibition, activation
    "miRNA_regulation" VARCHAR(20), -- how miRNA is regulated in the disease (up-regulated, down-regulated or normal)
    "gene_regulation" VARCHAR(20), -- how gene is regulated in the disease
    PRIMARY KEY("id"),
    FOREIGN KEY("miRNA_id") REFERENCES "miRNAs"("id"),
    FOREIGN KEY("gene_id") REFERENCES "genes"("id"),
    FOREIGN KEY("disease_id") REFERENCES "diseases"("id"),
    FOREIGN KEY("drug_id") REFERENCES "drugs"("id")
);

-- Many to many relationship tables
-- relationship between miRNA and genes
CREATE TABLE "miRNAs_genes" (
    "miRNAs_id" INT,
    "gene_id" INT,
    FOREIGN KEY("miRNAs_id") REFERENCES "miRNAs"("id"),
    FOREIGN KEY("gene_id") REFERENCES "genes"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "gene_name_search" ON "genes" ("name");
CREATE INDEX "gene_id_search" ON "genes" ("id");
CREATE INDEX "miRNA_name_search" ON "miRNAs" ("name");
CREATE INDEX "miRNA_id_search" ON "miRNAs" ("id");
CREATE INDEX "disease_name_search" ON "diseases" ("name");
CREATE INDEX "disease_id_search" ON "diseases" ("id");
