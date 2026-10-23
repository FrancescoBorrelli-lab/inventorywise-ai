# InventoryWise AI

SaaS intelligente per la gestione del magazzino con Computer Vision e analisi predittiva.

> 🚧 **Stato: base funzionante, in sviluppo.** L'app si avvia e mostra magazzino, scansione e chat con **dati di esempio**. La scansione AI e la chat usano per ora un'implementazione simulata (`MockAiService`): le API OpenAI/Gemini e il backend Supabase **non sono ancora collegati**, e la fotocamera non è ancora integrata.

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

## Struttura
- `lib/src/features/inventory`: modello, repository (in memoria), provider Riverpod e schermate del magazzino.
- `lib/src/features/ai_engine`: contratto `AiService` e implementazione simulata.
- `lib/src/services`: previsione del riordino (`ReorderPredictor`), con test.

## Come provarla

```sh
flutter pub get
flutter run
flutter test
```

Cosa funziona oggi: elenco articoli con giorni di scorta, suggerimenti di riordino (scorte < tempo di consegna + margine di sicurezza), scansione simulata di una bolla con conferma, chat che risponde a domande come "Quanti bulloni M8 abbiamo?" e "Cosa devo riordinare?".

## Obiettivo
L'obiettivo è dimostrare competenze nell'integrazione di LLM/API di Intelligenza Artificiale in un contesto applicativo reale, focalizzandosi sull'ottimizzazione dei processi di business.

## Licenza

[MIT](LICENSE)

## Autore

**Francesco Borrelli**, sviluppatore mobile, [borrellifrancesco.dev](https://borrellifrancesco.dev).
