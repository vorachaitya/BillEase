import Formdata from "./Formdata";
import { useEffect, useState } from "react";
import { createClient } from "@supabase/supabase-js";
import Export from "./Export";
import * as FileSaver from "file-saver";
import XLSX from "sheetjs-style";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Barcode from "react-barcode";
import "../css/table.css";
import Navi from "./Navi";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "";
const supabase = createClient(supabaseUrl, supabaseKey);

const Table = ({ handleChange, formInputData, handleUpdate, user }) => {
  const [stock, setStock] = useState([]);
  const [inventory, setInventory] = useState([]);
  const [show, setShow] = useState(false);
  const [id, setId] = useState();

  const handleClose = () => setShow(false);
  const handleShow = (id) => {
    // setShow(true);
    setId(id);
    console.log(id);
    setShow(true);
  };

  const handleEdit = () => {
    console.log("edit");

    return `<div>Hello</div>`;
  };
  let total = 0;
  let barcode = "";
let item="";
let price="";
let quantity="";
  useEffect(() => {
    getStock();
    getInventory();
  }, []);

  const obj = JSON.parse(user);
  async function getStock() {
    let { data } = await supabase
      .from("inventory")
      .select("id,barcode,item,price,quantity")
      .eq("username", `${obj}`);
    setStock(data);
    console.log(obj);
  }
  async function getInventory() {
    let { data } = await supabase
      .from("inventory")
      .select("barcode,item,price")
      .eq("username", `${obj}`);
    setInventory(data);
  }
  const handleDelete = async (barcode) => {
    const { data, error } = await supabase
      .from("inventory")
      .delete()
      .eq("barcode", barcode);
    window.location.reload(true);
    toast("Product deleted successfully!");
  };


  const fileType =
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=UTF-8";
  const fileExtension = ".xlsx";

  const exportToExcel = async () => {
    const ws = XLSX.utils.json_to_sheet(inventory);

    const wb = { Sheets: { data: ws }, SheetNames: ["data"] };

    const excelBuffer = XLSX.write(wb, { bookType: "xlsx", type: "array" });

    const data = new Blob([excelBuffer], { type: fileType });

    FileSaver.saveAs(data, "inventory" + fileExtension);
  };
  return (
    <>
      {/* <table className="table">
        <thead>
          <tr>
            <th>S.No</th>
            <th>Barcode</th>
            <th>Item Description</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Barcode</th>
          </tr>
        </thead>
        <tbody>
          {stock.map((data, index) => {
            total = total + data.price * data.quantity;

            console.log(total);
            return (
              <tr key={data.id}>
                <td>{index + 1}</td>
                <td>{data.barcode}</td>
                <td>{data.item}</td>
                <td>{data.price}</td>
                <td>{data.quantity}</td>
                <td>{`${data.price}` * `${data.quantity}`}</td>
                <td><Barcode value={data.barcode} /></td>
                <td>
                  <button
                    onClick={(event) => {
                      event.stopPropagation();
                      handleDelete(data.barcode);
                    }}
                  >
                    <box-icon type="solid" name="trash-alt"></box-icon>
                  
                  </button>
                </td>
                <td>
                  <button
                  onClick={(event) => {
                    // handleEdit();
                    handleShow(data.id);

                  }}  
                
                  >
                    <box-icon type="solid" name="edit-alt"></box-icon>
                  </button>
                  <Modal show={show} onHide={handleClose} id={id}>
                    <Modal.Header closeButton>
                      <Modal.Title>Modal heading</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                      <div className="form-row row">
                        <div className="col">
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.barcode}
                            name="barcode"
                            className="form-control"
                            placeholder="Barcode"
                          />
                        </div>
                        <div className="col">
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.item}
                            name="item"
                            className="form-control"
                            placeholder="Item Description"
                          />
                        </div>
                        <div className="col">
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.price}
                            name="price"
                            className="form-control"
                            placeholder="Price"
                          />
                        </div>
                        <div className="col">
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.quantity}
                            name="quantity"
                            className="form-control"
                            placeholder="Quantity"
                          />
                        </div>
                      </div>
                    </Modal.Body>
                    <Modal.Footer>
                      <Button variant="secondary" onClick={handleClose}>
                        Close
                      </Button>
                      <Button
                        variant="primary"
                        onClick={(event) => {
                          event.stopPropagation();
                          handleUpdate(id);
                        }}
                      >
                        Update
                      </Button>
                    </Modal.Footer>
                  </Modal>
                </td>
              </tr>
            );
          })}
        </tbody>
        <div>
          <h6>Total = {total}</h6>
        </div>
      </table> */}

      {/* <Export excelData={ans} fileName="Inventory" /> */}

      <Navi></Navi>
     <h1 style={{textAlign:'center'}} className="fall-down" data-splitting>Inventory</h1>
      <table>
        
        <thead>
          <tr class="thead">
            <th scope="col">S.No</th>
            <th scope="col">Id</th>
            <th scope="col">Item</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Total Price</th>
            <th scope="col" style={{width:'15rem'}}>Barcode</th>
            <th scope="col">Delete</th>
            <th scope="col">Edit</th>
          </tr>
        </thead>
        <tbody>
       
          {stock.map((data, index) => {
            total = total + data.price * data.quantity;

            console.log(total);
            return (
              <tr key={data.id}>
                <td data-label="S.No">{index + 1}</td>
                <td data-label="Id">{data.barcode}</td>
                <td data-label="Item">{data.item}</td>
                <td data-label="Price">&#8377;{data.price}</td>
                <td data-label="Quantity">{data.quantity}</td>
                <td data-label="Total Price">&#8377;{`${data.price}` * `${data.quantity}`}</td>
                <td data-label="Barcode"><Barcode value={data.barcode} /></td>
                <td data-label="Delete">
                  <button
                    onClick={(event) => {
                      event.stopPropagation();
                      handleDelete(data.barcode);
                    }}
                  >
                  
                    <box-icon type="solid" name="trash-alt"></box-icon>
                  
                  </button>
                </td>
                  <ToastContainer />
                <td data-label="Edit">
                  <button
                  onClick={(event) => {
                    // handleEdit();
                    handleShow(data.id);

                  }}  
                
                  >
                    <box-icon type="solid" name="edit-alt"></box-icon>
                  </button>
                  <Modal show={show} onHide={handleClose} id={id}>
                    {stock.map((data)=>{
                      if(data.id===id){
                        item = data.item;
                        price = data.price;
                        quantity = data.quantity;
                        barcode = data.barcode;
                      }
                    })}
                    <Modal.Header closeButton>
                      <Modal.Title style={{color:'#7C3AED',fontWeight:'bold'}}>Update Inventory</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                      <div className="form-row row">
                        <div className="col" >
                          <label>Barcode</label>
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.barcode}
                            name="barcode"
                            className="form-control"
                            placeholder={barcode}
                          />
                        </div>
                        <div className="col">
                          <label>Item</label>
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.item}
                            
                            name="item"
                            className="form-control"
                            placeholder={item}
                          />
                        </div>
                        <div className="col">
                        <label>Price</label>
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.price}
                            name="price"
                            className="form-control"
                            placeholder={price}
                          />
                        </div>
                        <div className="col">
                        <label>Quantity</label>
                          <input
                            type="text"
                            onChange={handleChange}
                            value={formInputData.quantity}
                            name="quantity"
                            className="form-control"
                            placeholder={quantity}
                          />
                        </div>
                      </div>
                    </Modal.Body>
                    <Modal.Footer>
                      <button className="btn first" onClick={handleClose}>
                        Close
                      </button>
                      <button className="btn first"

                        onClick={(event) => {
                          event.stopPropagation();
                          handleUpdate(id);
                        }}
                      >
                        Update
                      </button>
                    </Modal.Footer>
                  </Modal>
                </td>
              </tr>
            );
          })}
        </tbody>
        
      </table>
      {/* <Button onClick={(e) => exportToExcel()}>Excel</Button> */}
      <div style={{display:'flex'}}>
      <button className="btn fifth" style={{left:'1rem'}}>Total = &#8377;{total}</button>
      <button className="btn fifth" style={{textAlign:'center',left:'50rem'}} onClick={(e) => exportToExcel()}>Excel</button>
      
      </div>
     
    </>
  );
};

export default Table;
