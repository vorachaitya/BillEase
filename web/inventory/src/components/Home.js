import Navi from './Navi';
import '../css/home.css'
const Home = () => {
  return (
    <>
    <Navi/>
    {/* <nav>
  <div className="logo">
    <div className="arrow-down"></div>
  </div>
  <ul >
    <a style={{textDecoration:'none'}} href="/"><li>Home</li></a>
    <a style={{textDecoration:'none'}} href="/video"><li>Video Conferencing</li></a>
    <a style={{textDecoration:'none'}} href="/chat"><li>Chat</li></a>
    <a style={{textDecoration:'none'}} href="/timeline"><li>Timeline</li></a>
    <a style={{textDecoration:'none'}} href="/admin"><li>Admin</li></a>
    <a style={{textDecoration:'none'}} href="/logout"><li>Logout</li></a>
 
  
  </ul>
</nav> */}

<section className="banner">
  <div className="container">
    <div className="banner-text">
      <h1>BillEase</h1>
      
      <button><a href='/inventory' style={{color:'white',textDecoration:'none'}}>Inventory</a></button>
    </div>
  </div>
  <img className="banner-image" src="https://i.ibb.co/K5QD8R8/inventory-management-mistakes.png" alt="monitoring" />
 
</section>


    </>
  );
}

export default Home;