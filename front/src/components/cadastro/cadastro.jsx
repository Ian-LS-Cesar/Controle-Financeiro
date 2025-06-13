import React from 'react'

const cadastro = () => {
  // a primeira le a segunda altera 
  const [name, setName] = useState("");
  const[username,setUsername] = useState("");
  const[password, setPassword] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    alert("enviando dados:" + name + username + password);
  }

  return (
    <div className='container'>  
        <form onSubmit={handleSubmit}> 
            <h1> Cadastro </h1>
            
            <div>
          <div className='input-field'> 
              <input type="name" placeholder='Nome'
              required
              onChange={(e) => setNAME(e.target.value)}/>
              <FaUser className= "icon"/>
            </div>

            </div>
            <div className='input-field'> 
              <input type="email" placeholder='Email'
              required
              onChange={(e) => setUsername(e.target.value)}/>
              <FaUser className= "icon"/>
            </div>

            <div className='input-field'> 
              <input type="password" placeholder='Senha'
              onChange={(e) => setPassword = (e.target.value)}/>
              <FaLock className= "icon"/>
            </div>    

            <button>Entrar</button>   

        </form>
    </div>
  )
}



export default cadastro
