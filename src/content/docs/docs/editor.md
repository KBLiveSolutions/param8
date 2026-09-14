---
title: Editor
description: Web-based configuration editor
---

<div class="editor-page">
  <iframe
    src="/editor-app/"
    title="param8 Online Editor"
    class="editor-frame"
    allow="serial"
  ></iframe>
</div>

<style>
  .editor-page {
    width: 100%;
    margin: 0;
    padding: 0;
  }

  .editor-frame {
    display: block;
    width: 100%;
    height: calc(100vh - 4.5rem);
    min-height: 760px;
    border: 0;
    border-radius: 10px;
    background: #1a1a2e;
  }

  @media (max-width: 640px) {
    .editor-frame {
      height: calc(100vh - 4rem);
      min-height: 700px;
      border-radius: 6px;
    }
  }
</style>
