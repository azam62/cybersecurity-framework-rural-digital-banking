# Cybersecurity Framework for Rural Digital Banking

A final-year academic project built with **ASP.NET Web Forms (C#)** and **Microsoft SQL Server**. The application provides banking workflows with authentication and additional security-oriented features such as OTP, CAPTCHA, voice authentication, AES utilities, and user/admin modules.

## Tech Stack
- ASP.NET Web Forms / C#
- .NET Framework 4.7.2
- Microsoft SQL Server
- HTML, CSS, JavaScript
- Bootstrap / front-end libraries included in the project

## Main Modules
- User registration and login
- OTP-based verification
- CAPTCHA and voice-authentication components
- Deposit and withdrawal workflows
- Account/profile management
- Statements
- Government and bank schemes
- Admin dashboard and approvals
- AI recommendation / spending-analysis pages

## Run Locally
1. Open the `.sln` file in Visual Studio with ASP.NET/.NET Framework support installed.
2. Create/configure the required SQL Server database.
3. Copy `Web.config.example` to `Web.config` if needed and replace the placeholder SQL/SMTP values with your own local configuration.
4. Never commit real passwords, API keys, SMTP app passwords, or private user data.
5. Restore NuGet dependencies through Visual Studio/NuGet rather than committing the generated `packages`, `bin`, or `obj` folders.

## Important
This repository is a sanitized portfolio version of the academic project. Private credentials, generated build files, local Visual Studio files, and recorded voice data have intentionally been excluded.

## Project Structure
- `admin/` — administrator pages and controls
- `user/` — user-facing banking modules
- `App_Code/` — shared application code
- `assets/`, `Content/`, `css/`, `Scripts/`, `web_img/` — UI assets
- `Web.config.example` — configuration template

## Academic Project
This project was developed as a final-year academic project and is intended for educational/demo purposes.
