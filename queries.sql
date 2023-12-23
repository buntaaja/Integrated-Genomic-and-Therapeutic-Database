-- Search for miRNAs targeting a specific gene:
SELECT "genes"."name", "genes"."id", "miRNAs".*
FROM "miRNAs"
JOIN "genes" ON "miRNAs"."target_gene_id" = "genes"."id"
WHERE "genes"."name" = 'gene_name';

-- Search for genes associated with specific miRNAs:
SELECT "miRNAs"."name", "miRNAs"."id", "genes".*
FROM "genes"
JOIN "miRNAs_genes" ON "genes"."id" = "miRNAs_genes"."gene_id"
JOIN "miRNAs" ON "miRNAs_genes"."miRNAs_id" = "miRNAs"."id"
WHERE "miRNAs"."name" IN ('hsa-mir-26b', 'hsa-mir-146a', 'hsa-mir-200b');

-- Find genes associated with a particular disease:
SELECT "diseases"."name" AS "disease" , "genes".*
FROM "genes"
JOIN "interactions" ON "genes"."id" = "interactions"."gene_id"
JOIN "diseases" ON "interactions"."disease_id" = "diseases"."id"
WHERE "diseases"."name" = 'disease_name';

-- Identify miRNAs associated with a disease:
SELECT "diseases"."name" AS "disease", "miRNAs".*
FROM "miRNAs"
JOIN "interactions" ON "miRNAs"."id" = "interactions"."miRNAs_id"
JOIN "diseases" ON "interactions"."disease_id" = "diseases"."id"
WHERE "diseases"."name" = 'disease_name';

-- Find drugs targeting specific genes
SELECT "genes"."name", "drugs".*
FROM "drugs"
JOIN "genes" ON "drugs"."target_gene_id" = "genes"."id"
WHERE "genes"."name" = 'gene_name';

-- Identify drugs associated with particular disease
SELECT "diseases"."name", "drugs".*,
FROM "drugs"
JOIN "interactions" ON "drugs"."id" = "interactions"."drug_id"
JOIN "diseases" ON "interactions"."disease_id" = "diseases"."id"
WHERE "diseases"."name" = 'disease_name';

-- Add a new miRNA
INSERT INTO "miRNAs" ("name", "family", "seed", "source")
VALUES ('hsa-let-7e', 'LET-7', 'GAGGUAG', 'https://...');

-- Update miRNA information
UPDATE "miRNAs"
SET "family" = 'MIR-26'
WHERE "name" = 'hsa-mir-26b';

-- Update miRNA, Gene, Disease interaction in interactions table
UPDATE "interactions"
SET "miRNA_regulation" = 'up-regulated', "gene_regulation" = 'normal'
WHERE "miRNA_id" = 1 AND "gene_id" = 2 AND "disease_id" = 3;
