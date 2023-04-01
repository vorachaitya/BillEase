import logo from './logo.svg';
import './App.css';
import Body from './components/Error/Error';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Footer from './components/Footer/Footer';

function App() {
  return (
    <>
    
      
    <BrowserRouter>
 
   
        <Routes>
        <Route exact path='*' element={<Body/>} />
        </Routes>
        <Footer/>
        </BrowserRouter>
    </>
  );
}

export default App;
