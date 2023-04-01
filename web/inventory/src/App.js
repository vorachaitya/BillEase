import logo from './logo.svg';
import './App.css';
import Body from './components/Error/Error';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Footer from './components/Footer/Footer';
import Navbar from './components/Navbar/Navbar';

function App() {
  return (
    <>
    
      
    <BrowserRouter>
 
        <Navbar/>
        <Routes>
        <Route exact path='*' element={<Body/>} />
        </Routes>
        <Footer/>
        </BrowserRouter>
    </>
  );
}

export default App;
