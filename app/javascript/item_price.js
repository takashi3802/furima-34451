window.addEventListener("load",()=>{

  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

  const addTaxDom = document.getElementById("add-tax-price")
     addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

  const totalProfit = document.getElementById("profit")
     const taxResult = inputValue * 0.1
     totalProfit.innerHTML = Math.floor(inputValue - taxResult);
  })
})