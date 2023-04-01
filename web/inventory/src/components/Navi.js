import '../css/home.css'

const Navi = () => {
    const username = localStorage.getItem('username');
    const obj = JSON.parse(username)
    const handleLogout = () => {
		localStorage.removeItem("token");
		window.location.reload();
	};
    return (
        <>
            <nav>
                <div className="logo">
                <img className="banner-image" src="https://i.ibb.co/x24Kt1W/Screenshot-183.png" alt="monitoring" />
                  
                </div>
                <ul >
                    <a style={{ textDecoration: 'none', marginLeft:'1rem', fontSize:'large', fonteWeight:'700' }} href="/home"><li>Home</li></a>
                    <a style={{ textDecoration: 'none', marginLeft:'1rem', fontSize:'large', fonteWeight:'700' }} href="/inventory"><li>Inventory</li></a>
                    <a style={{ textDecoration: 'none', marginLeft:'1rem', fontSize:'large', fonteWeight:'700' }} href="/add"><li>Add</li></a>
                    <a style={{ textDecoration: 'none', marginLeft:'1rem', fontSize:'large', fonteWeight:'700' }} href="/" onClick={handleLogout}><li>Logout</li></a>
                    <a style={{ textDecoration: 'none', marginLeft:'49rem', fontSize:'large', fonteWeight:'700' }} href="#" onClick={handleLogout}><li>{obj}</li></a>
                    


                </ul>
            </nav>
        </>
    );
}

export default Navi;