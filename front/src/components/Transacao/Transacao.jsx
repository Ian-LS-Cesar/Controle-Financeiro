import React, { useEffect, useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import "./Transacao.css";

export default function Transacao() {
  const [menuOpen, setMenuOpen] = useState(false);
  const token = localStorage.getItem("token");
  const userId = localStorage.getItem("userId");
  console.log("userId do localStorage:", localStorage.getItem("userId"));
  const [categorias, setCategorias] = useState([]);
  const [descricao, setDescricao] = useState("");
  const [valor, setValor] = useState("");
  const [tipo, setTipo] = useState("0"); // valor inicial como string "0"
  const [data, setData] = useState("");
  const [novaCategoria, setNovaCategoria] = useState("");
  const [categoriasSelecionadas, setCategoriasSelecionadas] = useState([]);

  const navigate = useNavigate();

  useEffect(() => {
    if (!token || !userId) {
      navigate("/"); // redireciona para cadastro se não autenticado
      return;
    }
    fetch(`http://localhost:4000/api/users/${userId}`, {
      headers: {
        "Authorization": "Bearer " + token
      }
    })
      .then(resp => resp.json())
      .then(data => {
        // faça algo com os dados, se necessário
        // console.log(data);
      });
  }, [token, userId, navigate]);

  // Carrega categorias ao montar o componente
  useEffect(() => {
    carregarCategorias();
  }, []);


  async function carregarCategorias() {
    const resp = await fetch(`http://localhost:4000/api/users/${userId}/tags`, {
      headers: {
        "Authorization": `Bearer ${token}`
      }
    });
    if (resp.ok) {
      const data = await resp.json();
      setCategorias(data.tags || []);
    }
  }

  console.log(categorias);

  async function criarCategoria(e) {
    e.preventDefault();
    if (!novaCategoria.trim()) return alert("Digite o nome da categoria!");
    const resp = await fetch("http://localhost:4000/api/tags", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
      body: JSON.stringify({ tag: { nome: novaCategoria, id_user: Number(userId) } }),
    });
    if (resp.ok) {
      setNovaCategoria("");
      carregarCategorias();
    } else {
      alert("Erro ao criar categoria.");
    }
  }

  async function cadastrarTransacao(e) {
    e.preventDefault();
    if (!descricao.trim() || !valor || !data || categoriasSelecionadas.length === 0) {
      alert("Preencha todos os campos obrigatórios!");
      return;
    }
    const dataFormatada = data.length === 16 ? data + ":00" : data; // "2024-06-14T15:30:00"
    const body = {
      transaction: {
        descricao,
        valor: Number(valor),
        tipo,
        data: dataFormatada, // agora com datetime
        id_user: Number(userId),
        tags: categoriasSelecionadas.map(Number),
      },
    };
    const resp = await fetch("http://localhost:4000/api/transactions" , {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
      body: JSON.stringify(body),
    });
    const data2 = await resp.json();
    if (!resp.ok) {
     alert("Erro: " + JSON.stringify(data2));
     return;
    } 
    alert("Transação cadastrada com sucesso!");
    setDescricao("");
    setValor("");
    setTipo("0");
    setData("");
    setCategoriasSelecionadas([]);
  }

  return (
    <div className="transacao-container">
      {/* Menu sanduíche */}
      <div style={{ width: "100%", display: "flex", justifyContent: "flex-end", position: "relative" }}>
        <button
          style={{
            background: "none",
            border: "none",
            fontSize: "2rem",
            cursor: "pointer",
            color: "#fff",
            marginBottom: "10px"
          }}
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Abrir menu"
        >
          &#9776;
        </button>
        {menuOpen && (
          <div
            style={{
              position: "absolute",
              right: 0,
              top: "calc(100% + 8px)",
              background: "#fff",
              color: "#4d6347",
              borderRadius: "8px",
              boxShadow: "0 2px 8px rgba(0,0,0,0.15)",
              zIndex: 10,
              minWidth: "140px",
              display: "flex",
              flexDirection: "column"
            }}
          >
            <button
              style={{
                background: "none",
                border: "none",
                color: "#4d6347",
                padding: "12px 20px",
                width: "100%",
                textAlign: "left",
                cursor: "pointer",
                fontSize: "1rem"
              }}
              onClick={() => {
                setMenuOpen(false);
                navigate("/historico");
              }}
            >
              Histórico
            </button>
            <button
              style={{
                background: "none",
                border: "none",
                color: "#4d6347",
                padding: "12px 20px",
                width: "100%",
                textAlign: "left",
                cursor: "pointer",
                fontSize: "1rem"
              }}
              onClick={() => {
                localStorage.removeItem("token");
                localStorage.removeItem("userId");
                setMenuOpen(false);
                navigate("/login");
              }}
            >
              Log out
            </button>
          </div>
        )}
      </div>
      <h1>Transação</h1>
      <form id="form-transacao" onSubmit={cadastrarTransacao}>
        <input
          id="descricao"
          type="text"
          placeholder="Descrição"
          value={descricao}
          onChange={e => setDescricao(e.target.value)}
          required
        />
        <input
          id="valor"
          type="number"
          placeholder="Valor"
          value={valor}
          onChange={e => setValor(e.target.value)}
          required
        />
        <select
          id="tipo"
          value={tipo}
          onChange={e => setTipo(e.target.value)}
          required
        >
          <option value="0">Receita</option>
          <option value="1">Despesa</option>
        </select>
        <input
          id="data"
          type="datetime-local"
          value={data}
          onChange={e => setData(e.target.value)}
          required
        />

        <div className="nova-categoria-row">
          <input
            id="nova-categoria"
            type="text"
            placeholder="Nova categoria"
            value={novaCategoria}
            onChange={e => setNovaCategoria(e.target.value)}
          />
          <button type="button" id="btn-criar-categoria" onClick={criarCategoria}>
            Criar categoria
          </button>
        </div>

        <label htmlFor="categorias">
          Categorias <span style={{fontSize: "0.9em"}}>(Segure Ctrl ou Cmd para selecionar mais de uma)</span>
        </label>
        <select
          id="categorias"
          multiple
          required
          style={{ width: "100%", minHeight: 60 }}
          value={categoriasSelecionadas}
          onChange={e =>
            setCategoriasSelecionadas(
              Array.from(e.target.selectedOptions, opt => opt.value)
            )
          }
        >
          {categorias.map(cat => (
            <option key={cat.id} value={cat.id}>
              {cat.nome}
            </option>
          ))}
        </select>

        <button type="submit">Cadastrar</button>
      </form>
    </div>
  );
}