---
title: Order param8
slug: order
description: Order your param8 controller.
---

<div class="stripe-page">
  <iframe
    src="https://buy.stripe.com/bJe5kC2DBgwVfywaR9bjW00"
    title="Order param8"
    class="stripe-frame"
    allow="payment"
  ></iframe>
</div>

<style>
  .stripe-page {
    width: 100%;
    margin: 0;
    padding: 0;
  }

  .stripe-frame {
    display: block;
    width: 100%;
    height: calc(100vh - 4.5rem);
    min-height: 760px;
    border: 0;
    border-radius: 10px;
    background: white;
  }

  @media (max-width: 640px) {
    .stripe-frame {
      height: calc(100vh - 4rem);
      min-height: 700px;
      border-radius: 6px;
    }
  }
</style>
