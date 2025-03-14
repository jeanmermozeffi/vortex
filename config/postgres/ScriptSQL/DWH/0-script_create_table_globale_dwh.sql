CREATE TABLE "dim_temps"
(
    "dim_temps_id" INTEGER NOT NULL,  -- ID pour la dimension temporelle
    "date_day" DATE NOT NULL,  -- Date du jour
    "year_number" INTEGER NOT NULL,  -- Numéro de l'année
    "semester_number" INTEGER NOT NULL,  -- Numéro du semestre
    "quarter_number" INTEGER NOT NULL,  -- Numéro du trimestre
    "month_number" INTEGER NOT NULL,  -- Numéro du mois
    "day_of_year" INTEGER NOT NULL,  -- Jour de l'année
    "day_of_month" INTEGER NOT NULL,  -- Jour du mois
    "day_of_week" INTEGER NOT NULL,  -- Jour de la semaine
    "week_of_year" INTEGER NOT NULL,  -- Numéro de la semaine dans l'année
    "month_name" VARCHAR(100) NOT NULL,  -- Nom du mois
    "day_name" VARCHAR(100) NOT NULL,  -- Nom du jour
    "is_last_day_of_month" INTEGER NOT NULL,  -- Indicateur du dernier jour du mois
    "is_leap_year" INTEGER NOT NULL,  -- Indicateur d'année bissextile
    "is_weekend" INTEGER NOT NULL,  -- Indicateur des week-ends
    "is_holiday" INTEGER NOT NULL,  -- Indicateur des jours fériés
    "holiday_name" VARCHAR(100),  -- Nom du jour férié
    CONSTRAINT "dim_temps_pkey" PRIMARY KEY ("dim_temps_id")
);

----------------------------------------------------------------------------------------
----------------- Table de dimension des tâches : CIC_DWH".dim_taches" -----------------
----------------------------------------------------------------------------------------
CREATE TABLE "dim_taches"
(
    "dim_taches_id" SERIAL PRIMARY KEY NOT NULL,
    "task_type" VARCHAR(100) NOT NULL,
    "priority" VARCHAR(50),
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN
);

-- Table de dimension des techniciens
CREATE TABLE "dim_techniciens"
(
    "dim_techniciens_id" SERIAL PRIMARY KEY NOT NULL,
    "technician_name" VARCHAR(100) NOT NULL,
    "team_id" INT NOT NULL,
    "team_name" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN
);

CREATE TABLE dim_equipe
(
    "dim_team_id" SERIAL PRIMARY KEY NOT NULL,
    "team_name" VARCHAR(255) NOT NULL,
    "members_count" INT NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "status" BOOLEAN,
    "team_chief" VARCHAR(150),
    "entity" VARCHAR(50),
    "bl_ligne_active" BOOLEAN
);

CREATE TABLE dim_client
(
    "dim_client_id" SERIAL PRIMARY KEY NOT NULL,      -- Identifiant unique du client
    "client_name" VARCHAR(255) NOT NULL, -- Nom du client
    "client_type" VARCHAR(50),  -- Type de client (par exemple : "standard", "VVIP")
    "sector" VARCHAR(100),               -- Secteur d'activité du client (par exemple : "résidentiel", "entreprise")
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "bl_ligne_active" BOOLEAN
);

CREATE TABLE dim_etude
(
    "dim_etude_id" SERIAL PRIMARY KEY NOT NULL,
    "etude_type" VARCHAR(100) NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "bl_ligne_active" BOOLEAN
);


CREATE TABLE dim_incident
(
    "dim_incident_id" SERIAL PRIMARY KEY NOT NULL,
    "incident_type" VARCHAR(100) NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "bl_ligne_active" BOOLEAN
);

CREATE TABLE dim_projet
(
    "dim_projet_id" SERIAL PRIMARY KEY NOT NULL,
    "projet_name" VARCHAR(255) NOT NULL,
    "projet_type" VARCHAR(100) NOT NULL,
    "status" INT,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "bl_ligne_active" BOOLEAN
);