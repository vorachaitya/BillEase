import { useState, useEffect } from "react";
import Export from "./Export";
import FormInput from "./FormInput";
import Table from "./Table";
import { createClient } from "@supabase/supabase-js";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6aGxrY3dvbG5hZXJlb3dvZmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAwOTk2NzgsImV4cCI6MTk5NTY3NTY3OH0.LyyqZm5NOyK8oRkLqMpzggpEExpX5z-nyyDWgRsaAk4";
const supabase = createClient(supabaseUrl, supabaseKey);

const Formdata = () => {
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
    const newData = (data) => [...data, formInputData];
    setTableData(newData);
    console.log(formInputData);

    const { data, error } = await supabase.from("inventory").insert([
      {
        barcode: `${formInputData.barcode}`,
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

  const handleUpdate = async (id) => {
    
    const { data, error } = await supabase
      .from("inventory")
      .update({
        barcode: `${formInputData.barcode}`,
        item: `${formInputData.item}`,
        price: `${formInputData.price}`,
        quantity: `${formInputData.quantity}`,
        username: `${obj}`,
      })
      .eq("id", id);

      window.location.reload(true);
      toast("Product updated successfully!");
  };
  return (
    <>
      <div>
       
            {/* <FormInput
              handleChange={handleChange}
              formInputData={formInputData}
              handleSubmit={handleSubmit}
              user={user}
            /> */}
            <Table
              handleChange={handleChange}
              formInputData={formInputData}
              handleUpdate={handleUpdate}
              user={user}
            />
            <ToastContainer />
          </div>
          
        
     
    </>
  );
};

export default Formdata;
