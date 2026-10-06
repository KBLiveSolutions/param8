---
title: Order param8
description: Order your param8 controller.
---

<div class="order-page">
  <div class="order-card">
    <h1>Order param8</h1>
    <p>Order your param8 controller.</p>
    <p class="price"></p>
    <a class="order-button" href="https://buy.stripe.com/bJe5kC2DBgwVfywaR9bjW00" target="_blank" rel="noopener">1 unit : 189 €</a>
    <a class="order-button" href="https://buy.stripe.com/bJe5kC2DBgwVfywaR9bjW00" target="_blank" rel="noopener">2 units : 359.10 €</a> (2nd unit 10% off)
    <a class="order-button" href="https://buy.stripe.com/bJe5kC2DBgwVfywaR9bjW00" target="_blank" rel="noopener">3 units : 510.30 €</a> (3rd unit 20% off)
    <a class="order-button" href="https://buy.stripe.com/bJe5kC2DBgwVfywaR9bjW00" target="_blank" rel="noopener">4 units : 642.60 €</a> (4th unit 30% off)
  </div>
</div>



<!-- **param8** is available for **189€** -->

<style>
  .order-page {
    min-height: calc(100vh - 4rem);
    display: grid;
    place-items: center;
    padding: 2rem;
    box-sizing: border-box;
  }

  .order-card {
    width: min(520px, 100%);
    text-align: center;
    padding: 3rem 2rem;
    border: 1px solid #ddd;
    border-radius: 16px;
    background: white;
    box-sizing: border-box;
  }

  .order-card h1 { margin: 0 0 .75rem; font-size: 2rem; }
  .order-card p { margin: .5rem 0; color: #666; }
  .price { font-size: 2rem; font-weight: 700; color: #111 !important; margin: 1.5rem 0 !important; }
  .order-button { display: inline-block; padding: .8rem 1.4rem; border-radius: 8px; background: #111; color: white; text-decoration: none; font-weight: 600; }
  .order-button:hover { opacity: .85; }
</style>
