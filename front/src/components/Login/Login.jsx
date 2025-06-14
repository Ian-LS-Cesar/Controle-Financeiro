import React from 'react'
import {FaUser, FaLock} from 'react-icons/fa';
import { useState } from 'react';
import "./Login.css";
const Login = () => {
  // a primeira le a segunda altera 
  const[username,setUsername] = useState("");
  const[password, setPassword] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    alert("enviando dados:" + username + password);
  }

  return (
    <div className='container'>  
        <form onSubmit={handleSubmit}> 
            <h1> Login</h1>
            
            <div className='input-field'> 
              <input type="email" placeholder='Email'
              required
              onChange={(e) => setUsername(e.target.value)}/>
              <FaUser className= "icon"/>
            </div>

            <div className='input-field'> 
              <input type="passowrd" placeholder='Senha'
              onChange={(e) => setPassword = (e.target.value)}/>
              <FaLock className= "icon"/>
            </div>    

            {/* <div className='recall-forget'>
              <label>
                  <input type="checkbox"/>
                  lembre de mim
              </label>
              <a href="#">Esqueceu a senha?</a>
            </div> */}

            <button>Entrar</button>   

        </form>
    </div>
  )
}

export default Login
