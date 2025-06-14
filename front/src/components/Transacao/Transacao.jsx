import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Transacao.css";

export default function Transacao() {
  const token = localStorage.getItem("token");
  const userId = localStorage.getItem("userId");
  console.log("userId do localStorage:", localStorage.getItem("userId"));
  const [categorias, setCategorias] = useState([]);
  const [descricao, setDescricao] = useState("");
  const [valor, setValor] = useState("");
  const [tipo, setTipo] = useState("0");
  const [data, setData] = useState("");
  const [novaCategoria, setNovaCategoria] = useState("");
  const [categoriasSelecionadas, setCategoriasSelecionadas] = useState([]);

  const navigate = useNavigate();

  useEffect(() => {
    if (!token || !userId) {
      navigate("/"); // redireciona para login se não autenticado
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
      setCategorias(data.data || []);
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
    const body = {
      transaction: {
        descricao,
        valor,
        tipo,
        data,
        id_user: Number(userId),
        tags: categoriasSelecionadas.map(Number),
      },
    };
    const resp = await fetch("http://localhost:4000/api/transacoes", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
      body: JSON.stringify(body),
    });
    
    if (resp.ok) {
      alert("Transação cadastrada com sucesso!");
      setDescricao("");
      setValor("");
      setTipo("0");
      setData("");
      setCategoriasSelecionadas([]);
    } else {
      alert("Erro ao cadastrar transação.");
    }
  }

  return (
    <div className="transacao-container">
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
          type="date"
          value={data}
          onChange={e => setData(e.target.value)}
          required
        />

        <div style={{ marginBottom: 10 }}>
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