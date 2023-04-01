import logo from "./logo.svg";
import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
import Form from "react-bootstrap/Form";
import InputGroup from "react-bootstrap/InputGroup";
import { useState } from "react";
import FormInput from "./components/FormInput";
import Formdata from "./components/Formdata";
import Register from "./components/Register";
import Login from "./components/Login";
import Body from "./components/Error/Error"
import Home from "./components/Home"

import { BrowserRouter, Routes, Route } from 'react-router-dom';


function App() {


  return (
    <>
  
    <BrowserRouter>
     
        <Routes>
          <Route exact path='/' element={<Login />} />
          <Route exact path='/home' element={<Home />} />
          <Route exact path='/inventory' element={<Formdata />} />
          <Route exact path='/register' element={<Register />} />
          <Route exact path='/add' element={<FormInput />} />
          <Route exact path='*' element={<Body />} />
        </Routes>
    
    </BrowserRouter>
    </>
  );
}

export default App;
