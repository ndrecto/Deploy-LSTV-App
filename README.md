# Deploy-LSTV-App
REQUIREMENTS
Apache (v2.4.30+)
PHP (v7.3.25)
Requirement for payroll program
Must have php_dbase.dll php extension
https://pecl.php.net/package/dbase
Must have source guardian php extension
Must have Number_Words module in C:\xampp\php\pear\
https://pear.php.net/package/Numbers_Words
OpenSSl 1.1.1b
7zip
MariaDB (v10.3.24 or 10.5.4)
In the event that the server setup consists of separate application and database servers, MariaDB must also be installed on the application server to facilitate the service used during the system's structure update feature.

WEB INSTALLER 2025 service version
Apache v2.4.51
PHP 7.3.33
MariaDB 10.3.32
OpenSSL 3.1.5
7z 23.01

SERVICE INSTALLATION
Xampp Installation
XAMPP is a free and open-source cross-platform web server solution stack package that provides an easy-to-install distribution for Apache, MySQL (or MariaDB), and PHP, along with other useful tools. It is designed to help developers quickly set up a local development environment on their computers to test and develop web applications without needing a live server.
Use as the web service of system
Follow the step by step procedure, uncheck unnecessary tools, retain only apache, php and perl


MariaDB Installation
MariaDB is an open-source, relational database management system (RDBMS) that is a fork of MySQL. It is designed to be highly compatible with MySQL, making it a drop-in replacement in many cases, but it also comes with additional features, improved performance, and advanced security options
Use as the database service of system
Follow the step by step procedure, once ask for credential, check the “allow remote” and “use utf8 as default collation”
7zip Installation
7-Zip is a free and open-source file archiver software that allows users to compress (archive) and extract (unarchive) files in various formats. It is known for its high compression ratio, which makes it a popular tool for managing file archives, saving disk space, and facilitating file transfers.
Use in system update structure backup process
OpenSSL Installation
OpenSSL is an open-source implementation of the Secure Sockets Layer (SSL) and Transport Layer Security (TLS) protocols. It provides libraries and tools for securing communications over a network, commonly used for encrypting data, generating cryptographic keys, and verifying digital signatures. OpenSSL is widely used for securing connections between servers and clients, particularly in web environments (e.g., HTTPS)
