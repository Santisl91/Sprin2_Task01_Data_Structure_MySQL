# Sprin2_Task01_Data_Structure_SQL
# Database Modeling - Optics and Pizzeria Exercises

This repository presents the database designs for two distinct scenarios: an optician named "Cul d'Ampolla" and a pizzeria that facilitates online ordering.

## Optics - "Cul d'Ampolla"

### Tables Relations:
- The `glasses` table has foreign keys linking to the `Suppliers` and `Brands` tables.
- The `Clients` table has a foreign key that relates to itself for the `id_client_recomanador` field.

## Pizzeria

### Tables Relations:
- The `Localities` table has a foreign key that is related to the `Provinces` table.
- The `Comandes` table has a foreign key that is related to the `Clients/Es` table.
- The `Pizzes` and `Categories` tables have foreign keys that relate to each other.
- The `Pizzes` table has a foreign key that is related to the `Products` table.
- The `Empleats/Des` table has a foreign key that is related to the `Botigues` table.

These database structures establish a robust foundation for efficient management of optical and pizzeria information. Adjustments and optimizations can be made based on specific deployment requirements.

## Instructions for Use

### Environment Configuration:
1. Configure your system with a compatible database server (MySQL, PostgreSQL, etc.).
2. Execute the provided SQL scripts to create tables and establish relationships.

### Additional Development:
- If you wish to contribute or enhance the project, follow the standard workflow of forks and pull requests.

## Contact

For inquiries or assistance, feel free to reach out.

## License

This project is licensed under the MIT License.
