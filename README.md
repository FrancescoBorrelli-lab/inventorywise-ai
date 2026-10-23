# InventoryWise AI

SaaS intelligente per la gestione del magazzino con Computer Vision e analisi predittiva.

> 🚧 **Stato: in progettazione.** Questa repo contiene per ora solo la documentazione del progetto (problema, soluzione e stack previsto): il codice non è ancora stato scritto. Le sezioni qui sotto descrivono ciò che l'app farà, non ciò che è già implementato.

## Il Problema
La gestione manuale dell'inventario è lenta e soggetta a errori umani. Le aziende piccole e medie faticano a prevedere le scorte necessarie e perdono tempo nel data entry.

## La Soluzione
InventoryWise AI automatizza il lavoro pesante:
- **AI Scan:** Scansiona bolle o scaffali tramite fotocamera; l'AI estrae i dati e aggiorna il database in tempo reale.
- **Analisi Predittiva:** Algoritmi di analisi che suggeriscono quando riordinare la merce per evitare rotture di stock.
- **Interfaccia Chat:** Interroga il magazzino con linguaggio naturale ("Quanti bulloni M8 abbiamo?") e ricevi risposte immediate.

## Tech Stack
- **Framework:** Flutter
- **AI Integration:** OpenAI API / Gemini API
- **State Management:** Riverpod
- **Local Database:** Hive / Isar
- **Backend:** Supabase

## Struttura prevista
- `/lib/src/features/ai_engine`: Logica di comunicazione con le API di AI.
- `/lib/src/features/inventory`: Logica di gestione del magazzino.
- `/lib/src/services`: Integrazione Vision e Chat.

## Obiettivo
L'obiettivo è dimostrare competenze nell'integrazione di LLM/API di Intelligenza Artificiale in un contesto applicativo reale, focalizzandosi sull'ottimizzazione dei processi di business.

## Licenza

[MIT](LICENSE)

## Autore

**Francesco Borrelli**, sviluppatore mobile, [borrellifrancesco.dev](https://borrellifrancesco.dev).
