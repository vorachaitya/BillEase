import Formdata from "./Formdata";
import { useState } from "react";
import { createClient } from "@supabase/supabase-js";
import Navi from "./Navi";
import "../css/form.css"

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6aGxrY3dvbG5hZXJlb3dvZmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAwOTk2NzgsImV4cCI6MTk5NTY3NTY3OH0.LyyqZm5NOyK8oRkLqMpzggpEExpX5z-nyyDWgRsaAk4";
const supabase = createClient(supabaseUrl, supabaseKey);

const FormInput = () => {
  const [tableData, setTableData] = useState([]);
  const user = localStorage.getItem('username');
  console.log(user)
    const [formInputData, setFormInputData] = useState({
      barcode: "",
      item: "",
      price: "",
      quantity: "",
      username:"",
    });
    function randomgen() {
      var minm = 100000000000;
      var maxm = 999999999999;
      return Math.floor(Math.random() * (maxm - minm + 1)) + minm;
  }
    const handleChange = (event) => {
      const newInput = (data) => ({
        ...data,
        [event.target.name]: event.target.value,
      });
      setFormInputData(newInput);
    };
    const obj = JSON.parse(user)
    const handleSubmit = async (event) => {
      event.preventDefault();
      let random = randomgen();
      const newData = (data) => [...data, formInputData];
      setTableData(newData);
      console.log(formInputData);
  
      const { data, error } = await supabase.from("inventory").insert([
        {
          barcode: `${random}`,
          item: `${formInputData.item}`,
          price: `${formInputData.price}`,
          quantity: `${formInputData.quantity}`,
          username: `${obj}`,
        },
      ]);
  
      const emptyInput = { barcode: "", item: "", price: "", quantity: "" };
      setFormInputData(emptyInput);
      window.location.reload(true);
      console.log(tableData);
    };
  return (
    
    // <>
    // <Navi></Navi>
    //   <div className="form-row row">
    //     {/* <div className="col">
    //       <input
    //         type="text"
    //         onChange={handleChange}
    //         value={formInputData.barcode}
    //         name="barcode"
    //         className="form-control"
    //         placeholder="Barcode"
    //       />
    //     </div> */}
    //     <div className="col">
    //       <input
    //         type="text"
    //         onChange={handleChange}
    //         value={formInputData.item}
    //         name="item"
    //         className="form-control"
    //         placeholder="Item Description"
    //       />
    //     </div>
    //     <div className="col">
    //       <input
    //         type="text"
    //         onChange={handleChange}
    //         value={formInputData.price}
    //         name="price"
    //         className="form-control"
    //         placeholder="Price"
    //       />
    //       </div>
    //     <div className="col">
    //       <input
    //         type="text"
    //         onChange={handleChange}
    //         value={formInputData.quantity}
    //         name="quantity"
    //         className="form-control"
    //         placeholder="Quantity"
    //       />
    //     </div>
    //     <div className="col">
    //       <input
    //         type="submit"
    //         onClick={handleSubmit}
    //         className="btn btn-primary"
    //       />
    //     </div>
    //   </div>
    // </>
    <>
    <Navi/>
    <form class="enterOrder">
	<h3 class="enterOrderHeader" style={{color: 'white'}}>
		Add Item
	</h3>
	
	<label>Item</label>
  <input
            type="text"
            onChange={handleChange}
            value={formInputData.item}
            name="item"
            className="form-control"
            placeholder="Item Description"
          />
          <label>Price</label>
          <input
            type="text"
            onChange={handleChange}
            value={formInputData.price}
            name="price"
            className="form-control"
            placeholder="Price"
          />
          <label>Quantity</label>
          <input
            type="text"
            onChange={handleChange}
            value={formInputData.quantity}
            name="quantity"
            className="form-control"
            placeholder="Quantity"
          />
          <input
            className="blueButton"
            type="submit"
            onClick={handleSubmit}
          
          />


</form>
    </>
  );
};

export default FormInput;
