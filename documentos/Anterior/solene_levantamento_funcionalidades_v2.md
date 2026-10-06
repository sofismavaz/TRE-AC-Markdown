# LEVANTAMENTO TÉCNICO E DOCUMENTAL PARA MIGRAÇÃO
## Projeto: Solene - Gestão de Cerimonial
**Volume:** 2  
**Data de Gerada:** 2026-09-20 15:55:32  
**Tamanho Máximo Alvo:** 500 KB  
**Extensões Incluídas:** md php  
**Plataforma de Destino:** Agente de Inteligência Artificial / LLM  

---

> **INSTRUÇÃO PARA O AGENTE DE IA:**  
> Este arquivo contém a compilação estruturada de arquivos do projeto **Solene - Gestão de Cerimonial**.
> Cada arquivo fonte está delimitado por tags estruturadas `<arquivo>`, contendo os metadados de localização (`<pasta>`, `<subpasta>`, `<nome_arquivo>`, `<extensao>`) e o bloco de código/texto em `<conteudo>`.
> Utilize estes metadados para mapear o modelo de dados, as regras de negócio e os fluxos de migração.

---

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/dev</subpasta>
  <nome_arquivo>sessao.blade.php</nome_arquivo>
  <caminho_completo>resources/views/dev/sessao.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', 'Sessão de Dev · Solene Cerimonial')

@section('content')
    <div class="solene-card" style="max-width:560px;margin:0 auto;padding:1.75rem;">
        <h2 style="color:var(--solene-navy);"><i class="fas fa-user-cog"></i> Sessão simulada (dev)</h2>
        <p style="color:#64748b;">Troca o usuário/grupos do Authelia simulado sem reiniciar o container.</p>

        <form method="POST" action="{{ route('dev.sessao.set') }}" style="margin-top:1rem;">
            @csrf
            @php $defaults = array_merge($defaults, $atual); @endphp
            <label style="font-weight:600;">Username</label>
            <input name="username" value="{{ $defaults['username'] }}" required
                   style="width:100%;padding:.5rem;border:1px solid var(--solene-border);border-radius:6px;margin-bottom:.75rem;">
            <label style="font-weight:600;">Grupos (separados por vírgula)</label>
            <input name="groups" value="{{ $defaults['groups'] }}" required
                   style="width:100%;padding:.5rem;border:1px solid var(--solene-border);border-radius:6px;margin-bottom:.75rem;">
            <small style="color:#64748b;">Ex.: solene-admin ou solene-organizadores</small>
            <label style="font-weight:600;display:block;margin-top:.5rem;">Nome</label>
            <input name="nome" value="{{ $defaults['nome'] }}" required
                   style="width:100%;padding:.5rem;border:1px solid var(--solene-border);border-radius:6px;margin-bottom:.75rem;">
            <label style="font-weight:600;">Email</label>
            <input name="email" type="email" value="{{ $defaults['email'] }}" required
                   style="width:100%;padding:.5rem;border:1px solid var(--solene-border);border-radius:6px;margin-bottom:1rem;">
            <div style="display:flex;gap:.5rem;">
                <button type="submit" class="solene-btn"><i class="fas fa-check"></i> Aplicar</button>
            </div>
        </form>

        <form method="POST" action="{{ route('dev.sessao.reset') }}" style="margin-top:.75rem;">
            @csrf
            <button type="submit" class="solene-btn solene-btn--ghost"><i class="fas fa-undo"></i> Resetar para o .env</button>
        </form>
    </div>
@endsection

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/eventos</subpasta>
  <nome_arquivo>create.blade.php</nome_arquivo>
  <caminho_completo>resources/views/eventos/create.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', 'Criar Evento · Solene Cerimonial')

@section('content')
    <div class="solene-card" style="max-width:640px;margin:0 auto;padding:1.75rem;">
        <h2 style="color:var(--solene-navy);margin-bottom:1.25rem;">
            <i class="fas fa-calendar-plus"></i> Criar Novo Evento
        </h2>
        <form method="POST" action="{{ route('eventos.store') }}">
            @include('eventos._form')
        </form>
    </div>
@endsection

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/eventos</subpasta>
  <nome_arquivo>edit.blade.php</nome_arquivo>
  <caminho_completo>resources/views/eventos/edit.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', 'Editar Evento · Solene Cerimonial')

@section('content')
    <div class="solene-card" style="max-width:640px;margin:0 auto;padding:1.75rem;">
        <h2 style="color:var(--solene-navy);margin-bottom:1.25rem;">
            <i class="fas fa-edit"></i> Editar Evento
        </h2>
        <form method="POST" action="{{ route('eventos.update', $evento) }}">
            @include('eventos._form', ['metodo' => 'PUT'])
        </form>
    </div>
@endsection

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/eventos</subpasta>
  <nome_arquivo>_form.blade.php</nome_arquivo>
  <caminho_completo>resources/views/eventos/_form.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@csrf
@isset($metodo) @method($metodo) @endisset

<div style="margin-bottom:1rem;">
    <label for="nome" style="font-weight:600;">Nome do Evento</label>
    <input type="text" id="nome" name="nome" class="br-input"
           value="{{ old('nome', $evento->nome ?? '') }}" required
           style="width:100%;padding:.6rem;border:1px solid var(--solene-border);border-radius:8px;">
</div>

<div style="margin-bottom:1rem;">
    <label for="data" style="font-weight:600;">Data do Evento</label>
    <input type="date" id="data" name="data"
           value="{{ old('data', isset($evento) ? $evento->data?->format('Y-m-d') : '') }}" required
           style="width:100%;padding:.6rem;border:1px solid var(--solene-border);border-radius:8px;">
</div>

<div style="margin-bottom:1.5rem;">
    <label for="local" style="font-weight:600;">Local do Evento</label>
    <input type="text" id="local" name="local"
           value="{{ old('local', $evento->local ?? '') }}" required
           style="width:100%;padding:.6rem;border:1px solid var(--solene-border);border-radius:8px;">
</div>

<fieldset style="border:1px solid var(--solene-border);border-radius:10px;padding:1rem 1.1rem;margin-bottom:1.5rem;">
    <legend style="font-family:'Cormorant Garamond',Georgia,serif;font-size:1.15rem;color:var(--solene-navy);padding:0 .5rem;">
        <i class="fas fa-chair" style="color:var(--solene-gold);"></i> Capacidade de assentos
    </legend>
    <p style="color:var(--solene-muted);font-size:.82rem;margin:0 0 .9rem;">Número de poltronas por categoria, usado no mapa de assentos.</p>
    @php $caps = ['red' => '#ef4444', 'blue' => '#3b82f6', 'green' => '#22c55e', 'yellow' => '#eab308']; @endphp
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:.75rem;">
        @foreach (\App\Models\Evento::CAPACIDADE_LABELS as $cor => $rotulo)
            <div>
                <label for="cap_{{ $cor }}" style="font-size:.8rem;font-weight:600;display:flex;align-items:center;gap:.4rem;">
                    <span style="width:12px;height:12px;border-radius:3px;background:{{ $caps[$cor] }};display:inline-block;"></span>
                    {{ $rotulo }}
                </label>
                <input type="number" id="cap_{{ $cor }}" name="cap_{{ $cor }}" min="0" max="9999"
                       value="{{ old('cap_'.$cor, $evento->{'cap_'.$cor} ?? '') }}"
                       style="width:100%;padding:.5rem;border:1px solid var(--solene-border);border-radius:8px;">
            </div>
        @endforeach
    </div>
</fieldset>

<div style="display:flex;gap:.5rem;">
    <button type="submit" class="solene-btn"><i class="fas fa-save"></i> Salvar Evento</button>
    <a href="{{ route('eventos.index') }}" class="solene-btn solene-btn--ghost">Cancelar</a>
</div>

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/eventos</subpasta>
  <nome_arquivo>index.blade.php</nome_arquivo>
  <caminho_completo>resources/views/eventos/index.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', 'Eventos · Solene Cerimonial')

@section('content')
    <div style="text-align:center;margin-bottom:2rem;">
        <h1 style="color:var(--solene-navy);font-weight:700;">Eventos Institucionais</h1>
        <p style="color:#64748b;">Organize, acompanhe e execute as solenidades.</p>
    </div>

    @if ($eventos->isEmpty())
        <div class="solene-card" style="text-align:center;padding:2.5rem;">
            <h3>Nenhum evento cadastrado</h3>
            <p style="color:#64748b;">Que tal criar o primeiro agora?</p>
            <a href="{{ route('eventos.create') }}" class="solene-btn" style="margin-top:.5rem;">
                <i class="fas fa-plus"></i> Criar Primeiro Evento
            </a>
        </div>
    @else
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:1.25rem;">
            @foreach ($eventos as $evento)
                <div class="solene-card">
                    <div class="solene-card__head">{{ $evento->nome }}</div>
                    <a href="{{ route('eventos.show', $evento) }}" style="display:block;padding:1.25rem;text-decoration:none;color:inherit;">
                        <p><i class="fas fa-calendar-day" style="color:var(--solene-navy);"></i>
                            {{ $evento->data?->format('d/m/Y') }}</p>
                        <p><i class="fas fa-map-marker-alt" style="color:var(--solene-navy);"></i>
                            {{ $evento->local }}</p>
                        <p class="solene-badge">{{ $evento->presentes_count }} / {{ $evento->convidados_count }} presentes</p>
                    </a>
                    <div style="display:flex;gap:.5rem;padding:0 1.25rem 1.25rem;">
                        <a href="{{ route('eventos.edit', $evento) }}" class="solene-btn solene-btn--ghost" style="flex:1;justify-content:center;">
                            <i class="fas fa-edit"></i> Editar
                        </a>
                        <form method="POST" action="{{ route('eventos.destroy', $evento) }}" style="flex:1;"
                              onsubmit="return confirm('Excluir o evento e todos os convidados?');">
                            @csrf @method('DELETE')
                            <button type="submit" class="solene-btn solene-btn--danger" style="width:100%;justify-content:center;">
                                <i class="fas fa-trash"></i> Excluir
                            </button>
                        </form>
                    </div>
                </div>
            @endforeach
        </div>
    @endif
@endsection

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/eventos</subpasta>
  <nome_arquivo>show.blade.php</nome_arquivo>
  <caminho_completo>resources/views/eventos/show.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', $evento->nome.' · Solene Cerimonial')

@php
    $coresLabel = ['black' => 'Preto', 'red' => 'Vermelho', 'blue' => 'Azul', 'green' => 'Verde', 'yellow' => 'Amarelo'];
    $presentes = $evento->convidados->where('presente', true)->count();
@endphp

@push('styles')
<style>
    /* Formulário de adicionar convidado — fluido e responsivo */
    .ev-add-form {
        display: grid;
        grid-template-columns: 2fr 2fr 1.5fr 1fr auto;
        gap: .6rem; align-items: end; margin-bottom: 1.5rem;
    }
    .ev-add-form label { font-size: .8rem; font-weight: 600; display: block; margin-bottom: .2rem; }
    .ev-add-form input, .ev-add-form select {
        width: 100%; padding: .55rem; border: 1px solid var(--solene-border); border-radius: 8px;
    }
    .ev-add-form .solene-btn { justify-content: center; }
    @media (max-width: 780px) {
        .ev-add-form { grid-template-columns: 1fr 1fr; }
        .ev-add-form__submit { grid-column: 1 / -1; }
    }
    @media (max-width: 460px) {
        .ev-add-form { grid-template-columns: 1fr; }
    }

    /* Barra de ações do cabeçalho */
    .ev-actions { display: flex; flex-wrap: wrap; gap: .5rem; }
    @media (max-width: 520px) {
        .ev-actions { width: 100%; }
        .ev-actions .solene-btn { flex: 1 1 auto; justify-content: center; }
    }

    /* Tabela de convidados */
    .ev-table { width: 100%; border-collapse: collapse; }
    .ev-table thead tr { text-align: left; border-bottom: 2px solid var(--solene-gold); }
    .ev-table th { padding: .5rem; }
    .ev-table td { padding: .55rem .5rem; }
    .ev-table tbody tr { border-bottom: 1px solid var(--solene-border); }
    .ev-toggle { padding: .35rem .8rem; font-size: .8rem; border-radius: 999px; }

    /* Mobile: a tabela vira cartões empilhados com rótulos */
    @media (max-width: 720px) {
        .ev-table thead { display: none; }
        .ev-table, .ev-table tbody, .ev-table tr, .ev-table td { display: block; width: 100%; }
        .ev-table tr {
            border: 1px solid var(--solene-border); border-radius: 12px;
            box-shadow: var(--solene-shadow-sm); margin-bottom: .85rem; padding: .35rem .9rem;
            background: var(--solene-card);
        }
        .ev-table td {
            display: flex; align-items: center; justify-content: space-between; gap: 1rem;
            padding: .5rem 0; border: 0; text-align: left !important;
        }
        .ev-table td + td { border-top: 1px dashed var(--solene-border); }
        .ev-table td::before {
            content: attr(data-label); font-weight: 700; color: var(--solene-muted);
            font-size: .72rem; text-transform: uppercase; letter-spacing: .6px; flex: none;
        }
        .ev-table td[data-label="Nome"] { font-size: 1.05rem; }
    }
</style>
@endpush

@section('content')
    <a href="{{ route('eventos.index') }}" class="solene-btn solene-btn--ghost" style="margin-bottom:1rem;">
        <i class="fas fa-arrow-left"></i> Voltar para Eventos
    </a>

    <div style="text-align:center;margin:1.25rem 0;">
        <span style="display:inline-block;background:var(--solene-navy);color:#fff;padding:.4rem 1rem;border-radius:8px;font-weight:700;font-size:1.2rem;border-bottom:2px solid var(--solene-gold);">
            {{ $evento->nome }}
        </span>
        <div style="margin-top:.6rem;color:#64748b;">
            <i class="fas fa-calendar-day"></i> {{ $evento->data?->format('d/m/Y') }}
            &nbsp;·&nbsp; <i class="fas fa-map-marker-alt"></i> {{ $evento->local }}
        </div>
    </div>

    <div class="solene-card" style="padding:1.5rem;">
        <div style="display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between;gap:1rem;margin-bottom:1rem;">
            <div>
                <h2 style="color:var(--solene-navy);"><i class="fas fa-users"></i> Lista de Convidados</h2>
                <span class="solene-badge">{{ $presentes }} / {{ $evento->convidados->count() }} presentes</span>
            </div>
            <div class="ev-actions">
                <a href="{{ route('eventos.assentos', $evento) }}" class="solene-btn solene-btn--ghost"><i class="fas fa-chair"></i> Poltronas</a>
                <a href="{{ route('eventos.excel', $evento) }}" class="solene-btn solene-btn--ghost"><i class="fas fa-file-excel"></i> Excel</a>
                <a href="{{ route('eventos.nominata', $evento) }}" class="solene-btn"><i class="fas fa-file-pdf"></i> Nominata</a>
            </div>
        </div>

        {{-- Adicionar convidado --}}
        <form method="POST" action="{{ route('convidados.store', $evento) }}" class="ev-add-form">
            @csrf
            <div><label>Nome</label>
                <input name="nome" required style="text-transform:uppercase;"></div>
            <div><label>Titulação</label>
                <input name="titulacao" placeholder="Ex: Excelentíssimo Senhor"></div>
            <div><label>Cargo</label>
                <select name="cargo" required>
                    @foreach (\App\Models\Convidado::CARGOS as $cargo)<option value="{{ $cargo }}">{{ $cargo }}</option>@endforeach
                </select></div>
            <div><label>Cartão</label>
                <select name="cor" required>
                    @foreach ($coresLabel as $valor => $rotulo)<option value="{{ $valor }}">{{ $rotulo }}</option>@endforeach
                </select></div>
            <button type="submit" class="solene-btn ev-add-form__submit"><i class="fas fa-user-plus"></i> Adicionar</button>
        </form>

        @if ($evento->convidados->isEmpty())
            <p style="text-align:center;color:#64748b;padding:1.5rem;">Nenhum convidado adicionado ainda.</p>
        @else
            <table class="ev-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Cargo</th>
                        <th>Cartão</th>
                        <th style="text-align:center;">Presença</th>
                        <th style="text-align:right;">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($evento->convidados->sortBy('nome') as $c)
                        <tr>
                            <td data-label="Nome" style="font-weight:600;">{{ $c->nome }}</td>
                            <td data-label="Cargo">{{ $c->cargo }}</td>
                            <td data-label="Cartão">
                                <span class="assento assento--{{ $c->cor }}" style="vertical-align:middle;"></span>
                                {{ $coresLabel[$c->cor] ?? $c->cor }}
                            </td>
                            <td data-label="Presença" style="text-align:center;">
                                <form method="POST" action="{{ route('convidados.presenca', $c) }}" style="display:inline;">
                                    @csrf @method('PATCH')
                                    <button type="submit" class="solene-btn ev-toggle {{ $c->presente ? '' : 'solene-btn--ghost' }}">
                                        <i class="fas {{ $c->presente ? 'fa-check-circle' : 'fa-circle' }}"></i>
                                        {{ $c->presente ? 'Presente' : 'Ausente' }}
                                    </button>
                                </form>
                            </td>
                            <td data-label="Ações" style="text-align:right;">
                                <form method="POST" action="{{ route('convidados.destroy', $c) }}" style="display:inline;"
                                      onsubmit="return confirm('Excluir convidado?');">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="solene-btn solene-btn--danger" style="padding:.35rem .6rem;">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @endif
    </div>
@endsection

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/layouts</subpasta>
  <nome_arquivo>app.blade.php</nome_arquivo>
  <caminho_completo>resources/views/layouts/app.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', config('app.name'))</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Raleway:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/gh/fortawesome/Font-Awesome@5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@govbr-ds/core@3.7.0/dist/core.min.css" rel="stylesheet">
    <link href="{{ asset('css/solene-theme.css') }}?v={{ filemtime(public_path('css/solene-theme.css')) }}" rel="stylesheet">
    @stack('styles')
</head>
<body>
    <header class="solene-header">
        <div class="container-lg" style="display:flex;align-items:center;justify-content:space-between;padding:.75rem 1rem;">
            <a href="{{ route('eventos.index') }}" style="display:flex;align-items:center;gap:.75rem;text-decoration:none;">
                @php($logoPath = public_path('img/logo-solene.png'))
                @if (is_file($logoPath))
                    <img src="{{ asset('img/logo-solene.png') }}?v={{ filemtime($logoPath) }}" alt="Solene Cerimonial" class="solene-logo"
                         onerror="this.style.display='none'">
                @endif
            </a>
            <nav style="display:flex;align-items:center;gap:1rem;">
                <a href="{{ route('eventos.create') }}"><i class="fas fa-plus-circle"></i> Criar Evento</a>
                @if (session('user'))
                    <span style="opacity:.85;font-size:.9rem;">
                        <i class="fas fa-user-circle"></i> {{ session('user.username') }}
                        @if (session('is_admin')) · admin @endif
                    </span>
                @endif
            </nav>
        </div>
    </header>

    <main class="container-lg" style="padding:1.5rem 1rem;max-width:1200px;margin:0 auto;">
        @if (session('sucesso'))
            <div class="flash flash--ok"><i class="fas fa-check-circle"></i> {{ session('sucesso') }}</div>
        @endif
        @if (session('erro'))
            <div class="flash flash--erro"><i class="fas fa-exclamation-circle"></i> {{ session('erro') }}</div>
        @endif
        @if ($errors->any())
            <div class="flash flash--erro">
                <ul style="margin:0;padding-left:1.2rem;">
                    @foreach ($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach
                </ul>
            </div>
        @endif

        @yield('content')
    </main>

    <footer style="text-align:center;padding:.85rem 1.5rem;color:#94a3b8;font-size:.78rem;border-top:1px solid var(--solene-border);margin-top:1.5rem;display:flex;align-items:center;justify-content:center;gap:.6rem;">
        <span style="display:inline-block;width:32px;height:2px;background:linear-gradient(90deg,var(--solene-gold-2),var(--solene-gold));border-radius:2px;"></span>
        Solene Cerimonial · Tribunal Regional Eleitoral do Acre
    </footer>
</body>
</html>

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/pdf</subpasta>
  <nome_arquivo>nominata.blade.php</nome_arquivo>
  <caminho_completo>resources/views/pdf/nominata.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <style>
        @page { margin: 110px 40px 60px 40px; }
        body { font-family: DejaVu Sans, sans-serif; color: #1e293b; font-size: 11px; }
        header { position: fixed; top: -90px; left: 0; right: 0; text-align: center; }
        header .orgao { font-size: 9px; color: #64748b; letter-spacing: .5px; }
        header .titulo { font-size: 15px; color: #003366; font-weight: bold; margin-top: 6px; }
        header .subtitulo { font-size: 10px; color: #475569; margin-top: 2px; }
        .cargo { background: #003366; color: #fff; padding: 5px 10px; font-weight: bold;
                 font-size: 12px; margin-top: 14px; }
        table { width: 100%; border-collapse: collapse; }
        td { padding: 5px 10px; border-bottom: 1px solid #e2e8f0; vertical-align: top; }
        td.nome { width: 55%; font-weight: bold; }
        td.titulacao { color: #475569; }
        tr:nth-child(even) td { background: #f8fafc; }
        footer { position: fixed; bottom: -40px; left: 0; right: 0; text-align: center;
                 font-size: 8px; color: #94a3b8; }
    </style>
</head>
<body>
    <header>
        <div class="orgao">TRIBUNAL REGIONAL ELEITORAL DO ACRE</div>
        <div class="titulo">Nominata — {{ $evento->nome }}</div>
        <div class="subtitulo">
            {{ $evento->data?->format('d/m/Y') }} · {{ $evento->local }}
        </div>
    </header>

    <footer>Solene Cerimonial — gerado em {{ now()->format('d/m/Y H:i') }}</footer>

    <main>
        @foreach ($grupos as $cargo => $convidados)
            <div class="cargo">{{ $cargo }}</div>
            <table>
                @foreach ($convidados as $convidado)
                    <tr>
                        <td class="nome">{{ $convidado->nome }}</td>
                        <td class="titulacao">{{ $convidado->titulacao }}</td>
                    </tr>
                @endforeach
            </table>
        @endforeach
    </main>
</body>
</html>

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>routes</pasta>
  <subpasta>routes</subpasta>
  <nome_arquivo>console.php</nome_arquivo>
  <caminho_completo>routes/console.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment('Solene Cerimonial — TRE-AC');
})->purpose('Mensagem institucional');

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>routes</pasta>
  <subpasta>routes</subpasta>
  <nome_arquivo>web.php</nome_arquivo>
  <caminho_completo>routes/web.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use App\Http\Controllers\AssentoController;
use App\Http\Controllers\AutoridadeController;
use App\Http\Controllers\ConvidadoController;
use App\Http\Controllers\DevSessionController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\NominataController;
use App\Http\Middleware\EnsureNotProduction;
use Illuminate\Support\Facades\Route;

Route::middleware(['configure.session', 'authorize.route'])->group(function () {
    Route::get('/', fn () => redirect()->route('eventos.index'))->name('dashboard');

    // Eventos
    Route::get('/eventos', [EventoController::class, 'index'])->name('eventos.index');
    Route::get('/eventos/criar', [EventoController::class, 'create'])->name('eventos.create');
    Route::post('/eventos', [EventoController::class, 'store'])->name('eventos.store');
    Route::get('/eventos/{evento}', [EventoController::class, 'show'])->name('eventos.show');
    Route::get('/eventos/{evento}/editar', [EventoController::class, 'edit'])->name('eventos.edit');
    Route::put('/eventos/{evento}', [EventoController::class, 'update'])->name('eventos.update');
    Route::delete('/eventos/{evento}', [EventoController::class, 'destroy'])->name('eventos.destroy');

    // Exportações e mapa de assentos (implementados na iteração da Nominata)
    Route::get('/eventos/{evento}/nominata', [NominataController::class, 'pdf'])->name('eventos.nominata');
    Route::get('/eventos/{evento}/excel', [NominataController::class, 'excel'])->name('eventos.excel');
    Route::get('/eventos/{evento}/assentos', [NominataController::class, 'assentos'])->name('eventos.assentos');

    // Sentar/liberar autoridades nas poltronas + busca no cadastro global
    Route::get('/autoridades/buscar', [AutoridadeController::class, 'buscar'])->name('autoridades.buscar');
    Route::post('/eventos/{evento}/assentos', [AssentoController::class, 'sentar'])->name('assentos.sentar');
    Route::delete('/eventos/{evento}/assentos/{convidado}', [AssentoController::class, 'liberar'])->name('assentos.liberar');

    // Convidados
    Route::post('/eventos/{evento}/convidados', [ConvidadoController::class, 'store'])->name('convidados.store');
    Route::put('/convidados/{convidado}', [ConvidadoController::class, 'update'])->name('convidados.update');
    Route::patch('/convidados/{convidado}/presenca', [ConvidadoController::class, 'presenca'])->name('convidados.presenca');
    Route::delete('/convidados/{convidado}', [ConvidadoController::class, 'destroy'])->name('convidados.destroy');
});

// Ferramenta de desenvolvimento — troca de usuário simulado (Authelia).
// Bloqueada em produção (404). Está em bypass da ACL via config/acesso.php.
Route::middleware(EnsureNotProduction::class)
    ->prefix('_dev')->group(function () {
        Route::get('/sessao', [DevSessionController::class, 'form'])->name('dev.sessao.form');
        Route::post('/sessao', [DevSessionController::class, 'set'])->name('dev.sessao.set');
        Route::post('/sessao/reset', [DevSessionController::class, 'reset'])->name('dev.sessao.reset');
    });

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Acl</subpasta>
  <nome_arquivo>AcessoRotaPermissaoServiceTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Acl/AcessoRotaPermissaoServiceTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Acl;

use App\Models\AcessoRota;
use App\Models\GrupoAcesso;
use App\Services\AcessoRotaPermissaoService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AcessoRotaPermissaoServiceTest extends TestCase
{
    use RefreshDatabase;

    private function vincular(string $grupoNome, string $rotaNome): GrupoAcesso
    {
        $grupo = GrupoAcesso::create([
            'nome' => $grupoNome,
            'categoria' => GrupoAcesso::CATEGORIA_ORGANIZADOR,
            'ativo' => true,
        ]);
        $rota = AcessoRota::firstOrCreate(['rota_nome' => $rotaNome], ['ativo' => true]);
        $grupo->rotas()->syncWithoutDetaching([$rota->id => ['ativo' => true]]);

        return $grupo;
    }

    public function test_grupo_vinculado_a_rota_pode_acessar(): void
    {
        $this->vincular('TESTE-GRUPO', 'rota.alfa');

        $pode = app(AcessoRotaPermissaoService::class)
            ->podeAcessarRota('rota.alfa', ['TESTE-GRUPO']);

        $this->assertTrue($pode);
    }

    public function test_grupo_sem_vinculo_nao_pode_acessar(): void
    {
        $this->vincular('TESTE-GRUPO', 'rota.alfa');

        $pode = app(AcessoRotaPermissaoService::class)
            ->podeAcessarRota('rota.beta', ['TESTE-GRUPO']);

        $this->assertFalse($pode);
    }

    public function test_grupo_com_curinga_acessa_qualquer_rota(): void
    {
        $this->vincular('TESTE-ADMIN', AcessoRota::CURINGA);

        $pode = app(AcessoRotaPermissaoService::class)
            ->podeAcessarRota('qualquer.rota.nova', ['TESTE-ADMIN']);

        $this->assertTrue($pode);
    }

    public function test_sem_grupos_nao_pode_acessar(): void
    {
        $pode = app(AcessoRotaPermissaoService::class)
            ->podeAcessarRota('rota.alfa', []);

        $this->assertFalse($pode);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Acl</subpasta>
  <nome_arquivo>AcessoSeederTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Acl/AcessoSeederTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Acl;

use App\Models\AcessoRota;
use App\Models\GrupoAcesso;
use Database\Seeders\AcessoSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AcessoSeederTest extends TestCase
{
    use RefreshDatabase;

    public function test_cria_grupo_admin_com_curinga(): void
    {
        (new AcessoSeeder)->run();

        $admin = GrupoAcesso::where('nome', 'SOLENE-ADMIN')->first();

        $this->assertNotNull($admin);
        $this->assertSame(GrupoAcesso::CATEGORIA_ADMIN, $admin->categoria);
        $this->assertTrue(
            $admin->rotas()->where('rota_nome', AcessoRota::CURINGA)->exists(),
        );
    }

    public function test_cria_grupo_organizadores(): void
    {
        (new AcessoSeeder)->run();

        $org = GrupoAcesso::where('nome', 'SOLENE-ORGANIZADORES')->first();

        $this->assertNotNull($org);
        $this->assertSame(GrupoAcesso::CATEGORIA_ORGANIZADOR, $org->categoria);
    }

    public function test_e_idempotente(): void
    {
        (new AcessoSeeder)->run();
        (new AcessoSeeder)->run();

        $this->assertSame(1, GrupoAcesso::where('nome', 'SOLENE-ADMIN')->count());
        $this->assertSame(1, GrupoAcesso::where('nome', 'SOLENE-ORGANIZADORES')->count());
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Acl</subpasta>
  <nome_arquivo>MiddlewareAclTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Acl/MiddlewareAclTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Acl;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use App\Models\AcessoRota;
use App\Models\GrupoAcesso;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Route;
use Tests\TestCase;

class MiddlewareAclTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        Route::middleware(['web', ConfigureUserSession::class, AuthorizeRouteAccess::class])
            ->get('/_teste/protegida', fn () => response('ok'))
            ->name('teste.protegida');
    }

    private function vincular(string $grupo, string $categoria, string $rota): void
    {
        $g = GrupoAcesso::updateOrCreate(
            ['nome' => $grupo],
            ['categoria' => $categoria, 'ativo' => true],
        );
        $r = AcessoRota::firstOrCreate(['rota_nome' => $rota], ['ativo' => true]);
        $g->rotas()->syncWithoutDetaching([$r->id => ['ativo' => true]]);
    }

    public function test_sem_identidade_retorna_401(): void
    {
        $this->get('/_teste/protegida')->assertStatus(401);
    }

    public function test_grupo_desconhecido_retorna_403(): void
    {
        $this->withHeaders([
            'Remote-User' => 'fulano',
            'Remote-Groups' => 'grupo-inexistente',
        ])->get('/_teste/protegida')->assertStatus(403);
    }

    public function test_grupo_sem_permissao_na_rota_retorna_403(): void
    {
        $this->vincular('SOLENE-ORGANIZADORES', GrupoAcesso::CATEGORIA_ORGANIZADOR, 'outra.rota');

        $this->withHeaders([
            'Remote-User' => 'fulano',
            'Remote-Groups' => 'solene-organizadores',
        ])->get('/_teste/protegida')->assertStatus(403);
    }

    public function test_grupo_autorizado_acessa_e_cria_usuario(): void
    {
        $this->vincular('SOLENE-ORGANIZADORES', GrupoAcesso::CATEGORIA_ORGANIZADOR, 'teste.protegida');

        $this->withHeaders([
            'Remote-User' => 'fulano',
            'Remote-Groups' => 'solene-organizadores',
            'Remote-Name' => 'Fulano de Tal',
            'Remote-Email' => 'fulano@treac.local',
        ])->get('/_teste/protegida')->assertOk()->assertSee('ok');

        $this->assertDatabaseHas('usuarios', ['username' => 'fulano', 'nome' => 'Fulano de Tal']);
    }

    public function test_admin_curinga_acessa_qualquer_rota(): void
    {
        $this->vincular('SOLENE-ADMIN', GrupoAcesso::CATEGORIA_ADMIN, AcessoRota::CURINGA);

        $this->withHeaders([
            'Remote-User' => 'chefe',
            'Remote-Groups' => 'solene-admin',
        ])->get('/_teste/protegida')->assertOk();

        $this->assertTrue(session('is_admin'));
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature</subpasta>
  <nome_arquivo>DevSessionTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/DevSessionTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DevSessionTest extends TestCase
{
    use RefreshDatabase;

    public function test_define_sessao_simulada(): void
    {
        $this->post('/_dev/sessao', [
            'username' => 'maria.dev',
            'groups' => 'solene-admin',
            'nome' => 'Maria Dev',
            'email' => 'maria@treac.local',
        ])->assertRedirect('/');

        $this->assertSame('maria.dev', session('dev_session.username'));
    }

    public function test_reseta_sessao_simulada(): void
    {
        $this->withSession(['dev_session' => ['username' => 'x']])
            ->post('/_dev/sessao/reset')
            ->assertRedirect('/');

        $this->assertNull(session('dev_session'));
    }

    public function test_em_producao_retorna_404(): void
    {
        app()['env'] = 'production';

        $this->get('/_dev/sessao')->assertNotFound();
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Dominio</subpasta>
  <nome_arquivo>AssentoSeatingTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Dominio/AssentoSeatingTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Dominio;

use App\Models\Autoridade;
use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AssentoSeatingTest extends TestCase
{
    use RefreshDatabase;

    private function comoOrganizador()
    {
        return $this->withHeaders([
            'Remote-User' => 'organizador.teste',
            'Remote-Groups' => 'solene-organizadores',
            'Remote-Name' => 'Organizador Teste',
            'Remote-Email' => 'org@treac.local',
        ]);
    }

    private function evento(): Evento
    {
        return Evento::create([
            'nome' => 'Posse Solene', 'data' => '2026-06-10', 'local' => 'Plenário',
            'cap_red' => 6, 'cap_blue' => 4, 'cap_green' => 0, 'cap_yellow' => 0,
        ]);
    }

    public function test_busca_autoridades_por_nome(): void
    {
        Autoridade::create(['nome' => 'DESEMBARGADOR FULANO', 'cargo' => 'Desembargadores']);
        Autoridade::create(['nome' => 'JUIZ BELTRANO', 'cargo' => 'Juízes']);

        $this->comoOrganizador()
            ->getJson('/autoridades/buscar?q=fulano')
            ->assertOk()
            ->assertJsonCount(1)
            ->assertJsonFragment(['nome' => 'DESEMBARGADOR FULANO']);
    }

    public function test_sentar_nova_autoridade_cria_cadastro_e_convidado(): void
    {
        $evento = $this->evento();

        $this->comoOrganizador()->post("/eventos/{$evento->id}/assentos", [
            'cor' => 'red', 'numero' => 2,
            'nome' => 'joão da silva', 'titulacao' => 'Excelentíssimo Senhor', 'cargo' => 'Desembargadores',
        ])->assertRedirect();

        $this->assertDatabaseHas('autoridades', ['nome' => 'JOÃO DA SILVA', 'cargo' => 'Desembargadores']);
        $this->assertDatabaseHas('convidados', [
            'evento_id' => $evento->id, 'nome' => 'JOÃO DA SILVA',
            'cor' => 'red', 'assento_numero' => 2, 'presente' => true,
        ]);
    }

    public function test_sentar_autoridade_existente(): void
    {
        $evento = $this->evento();
        $autoridade = Autoridade::create(['nome' => 'DRA. MARIA', 'cargo' => 'Juízes']);

        $this->comoOrganizador()->post("/eventos/{$evento->id}/assentos", [
            'cor' => 'blue', 'numero' => 1, 'autoridade_id' => $autoridade->id,
        ])->assertRedirect();

        $this->assertDatabaseHas('convidados', [
            'evento_id' => $evento->id, 'autoridade_id' => $autoridade->id,
            'cor' => 'blue', 'assento_numero' => 1,
        ]);
    }

    public function test_nao_senta_em_poltrona_ocupada(): void
    {
        $evento = $this->evento();
        $a = Autoridade::create(['nome' => 'PRIMEIRO', 'cargo' => 'Juízes']);
        $b = Autoridade::create(['nome' => 'SEGUNDO', 'cargo' => 'Juízes']);

        $this->comoOrganizador()->post("/eventos/{$evento->id}/assentos", [
            'cor' => 'blue', 'numero' => 1, 'autoridade_id' => $a->id,
        ])->assertRedirect();

        $this->comoOrganizador()->post("/eventos/{$evento->id}/assentos", [
            'cor' => 'blue', 'numero' => 1, 'autoridade_id' => $b->id,
        ])->assertSessionHas('erro');

        $this->assertSame(1, Convidado::where('cor', 'blue')->where('assento_numero', 1)->count());
    }

    public function test_nao_senta_fora_da_capacidade(): void
    {
        $evento = $this->evento();
        $a = Autoridade::create(['nome' => 'X', 'cargo' => 'Juízes']);

        $this->comoOrganizador()->post("/eventos/{$evento->id}/assentos", [
            'cor' => 'blue', 'numero' => 99, 'autoridade_id' => $a->id, // capacidade azul = 4
        ])->assertSessionHas('erro');

        $this->assertDatabaseMissing('convidados', ['assento_numero' => 99]);
    }

    public function test_libera_poltrona(): void
    {
        $evento = $this->evento();
        $convidado = $evento->convidados()->create([
            'nome' => 'OCUPANTE', 'cargo' => 'Juízes', 'cor' => 'blue',
            'assento_numero' => 3, 'presente' => true,
        ]);

        $this->comoOrganizador()
            ->delete("/eventos/{$evento->id}/assentos/{$convidado->id}")
            ->assertRedirect();

        $this->assertDatabaseMissing('convidados', ['id' => $convidado->id]);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Dominio</subpasta>
  <nome_arquivo>EventoConvidadoTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Dominio/EventoConvidadoTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Dominio;

use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class EventoConvidadoTest extends TestCase
{
    use RefreshDatabase;

    private function evento(array $attrs = []): Evento
    {
        return Evento::create(array_merge([
            'nome' => 'Posse Solene',
            'data' => '2026-06-10',
            'local' => 'Plenário do TRE-AC',
        ], $attrs));
    }

    private function convidado(Evento $evento, array $attrs = []): Convidado
    {
        return $evento->convidados()->create(array_merge([
            'nome' => 'FULANO DE TAL',
            'titulacao' => 'Excelentíssimo Senhor',
            'cargo' => 'Juízes',
            'cor' => 'blue',
            'presente' => false,
        ], $attrs));
    }

    public function test_evento_tem_muitos_convidados(): void
    {
        $evento = $this->evento();
        $this->convidado($evento);
        $this->convidado($evento, ['nome' => 'SICRANO']);

        $this->assertCount(2, $evento->refresh()->convidados);
    }

    public function test_excluir_evento_remove_convidados_em_cascata(): void
    {
        $evento = $this->evento();
        $this->convidado($evento);

        $evento->delete();

        $this->assertSame(0, Convidado::count());
    }

    public function test_presente_e_booleano(): void
    {
        $evento = $this->evento();
        $c = $this->convidado($evento, ['presente' => true]);

        $this->assertTrue($c->refresh()->presente);
    }

    public function test_conta_convidados_presentes(): void
    {
        $evento = $this->evento();
        $this->convidado($evento, ['presente' => true]);
        $this->convidado($evento, ['nome' => 'AUSENTE', 'presente' => false]);

        $this->assertSame(1, $evento->convidadosPresentes()->count());
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Dominio</subpasta>
  <nome_arquivo>EventoHttpTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Dominio/EventoHttpTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Dominio;

use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class EventoHttpTest extends TestCase
{
    use RefreshDatabase;

    /** Requisição autenticada como organizador (headers Authelia). */
    private function comoOrganizador()
    {
        return $this->withHeaders([
            'Remote-User' => 'organizador.teste',
            'Remote-Groups' => 'solene-organizadores',
            'Remote-Name' => 'Organizador Teste',
            'Remote-Email' => 'org@treac.local',
        ]);
    }

    public function test_organizador_cria_evento(): void
    {
        $this->comoOrganizador()->post('/eventos', [
            'nome' => 'Posse Solene',
            'data' => '2026-06-10',
            'local' => 'Plenário do TRE-AC',
        ])->assertRedirect();

        $this->assertDatabaseHas('eventos', ['nome' => 'Posse Solene']);
    }

    public function test_criar_evento_exige_campos(): void
    {
        $this->comoOrganizador()->post('/eventos', [
            'nome' => '',
        ])->assertSessionHasErrors(['nome', 'data', 'local']);
    }

    public function test_evento_novo_recebe_capacidade_padrao(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);

        $this->assertSame(36, $evento->refresh()->cap_red);
        $this->assertSame(60, $evento->cap_yellow);
    }

    public function test_atualiza_capacidade_de_assentos(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);

        $this->comoOrganizador()->put("/eventos/{$evento->id}", [
            'nome' => 'Evento Teste', 'data' => '2026-06-10', 'local' => 'Plenário',
            'cap_red' => 10, 'cap_blue' => 8, 'cap_green' => 12, 'cap_yellow' => 20,
        ])->assertRedirect();

        $this->assertDatabaseHas('eventos', [
            'id' => $evento->id, 'cap_red' => 10, 'cap_blue' => 8, 'cap_green' => 12, 'cap_yellow' => 20,
        ]);
    }

    public function test_capacidade_nao_aceita_valor_negativo(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);

        $this->comoOrganizador()->put("/eventos/{$evento->id}", [
            'nome' => 'Evento Teste', 'data' => '2026-06-10', 'local' => 'Plenário', 'cap_red' => -5,
        ])->assertSessionHasErrors('cap_red');
    }

    public function test_organizador_exclui_evento(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);

        $this->comoOrganizador()->delete("/eventos/{$evento->id}")->assertRedirect();

        $this->assertDatabaseMissing('eventos', ['id' => $evento->id]);
    }

    public function test_adiciona_convidado_em_caixa_alta(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);

        $this->comoOrganizador()->post("/eventos/{$evento->id}/convidados", [
            'nome' => 'joão da silva',
            'titulacao' => 'Excelentíssimo Senhor',
            'cargo' => 'Juízes',
            'cor' => 'blue',
        ])->assertRedirect();

        $this->assertDatabaseHas('convidados', [
            'evento_id' => $evento->id,
            'nome' => 'JOÃO DA SILVA',
            'cargo' => 'Juízes',
            'presente' => false,
        ]);
    }

    public function test_alterna_presenca_do_convidado(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);
        $c = $evento->convidados()->create([
            'nome' => 'FULANO', 'cargo' => 'Convidados', 'cor' => 'yellow', 'presente' => false,
        ]);

        $this->comoOrganizador()->patch("/convidados/{$c->id}/presenca")->assertRedirect();

        $this->assertTrue($c->refresh()->presente);
    }

    public function test_exclui_convidado(): void
    {
        $evento = Evento::create(['nome' => 'X', 'data' => '2026-06-10', 'local' => 'Y']);
        $c = $evento->convidados()->create([
            'nome' => 'FULANO', 'cargo' => 'Convidados', 'cor' => 'yellow', 'presente' => false,
        ]);

        $this->comoOrganizador()->delete("/convidados/{$c->id}")->assertRedirect();

        $this->assertSame(0, Convidado::count());
    }

    public function test_usuario_sem_grupo_recebe_403(): void
    {
        $this->withHeaders([
            'Remote-User' => 'estranho',
            'Remote-Groups' => 'outro-sistema',
        ])->get('/eventos')->assertStatus(403);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Dominio</subpasta>
  <nome_arquivo>NominataControllerTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Dominio/NominataControllerTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Dominio;

use App\Models\Evento;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NominataControllerTest extends TestCase
{
    use RefreshDatabase;

    private function comoOrganizador()
    {
        return $this->withHeaders([
            'Remote-User' => 'org.teste',
            'Remote-Groups' => 'solene-organizadores',
        ]);
    }

    private function eventoComPresente(): Evento
    {
        $evento = Evento::create(['nome' => 'Posse', 'data' => '2026-06-10', 'local' => 'Plenário']);
        $evento->convidados()->create([
            'nome' => 'ANA', 'cargo' => 'Juízes', 'cor' => 'blue', 'presente' => true,
        ]);

        return $evento;
    }

    public function test_nominata_gera_pdf(): void
    {
        $evento = $this->eventoComPresente();

        $resp = $this->comoOrganizador()->get("/eventos/{$evento->id}/nominata");

        $resp->assertOk();
        $this->assertSame('application/pdf', $resp->headers->get('content-type'));
    }

    public function test_nominata_sem_presentes_volta_com_erro(): void
    {
        $evento = Evento::create(['nome' => 'Vazio', 'data' => '2026-06-10', 'local' => 'X']);

        $this->comoOrganizador()
            ->get("/eventos/{$evento->id}/nominata")
            ->assertRedirect()
            ->assertSessionHas('erro');
    }

    public function test_excel_gera_download(): void
    {
        $evento = $this->eventoComPresente();

        $resp = $this->comoOrganizador()->get("/eventos/{$evento->id}/excel");

        $resp->assertOk();
        $this->assertStringContainsString('attachment', (string) $resp->headers->get('content-disposition'));
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Feature/Views</subpasta>
  <nome_arquivo>RenderizacaoTest.php</nome_arquivo>
  <caminho_completo>tests/Feature/Views/RenderizacaoTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Views;

use App\Models\Evento;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RenderizacaoTest extends TestCase
{
    use RefreshDatabase;

    private function comoOrganizador()
    {
        return $this->withHeaders([
            'Remote-User' => 'org.teste',
            'Remote-Groups' => 'solene-organizadores',
            'Remote-Name' => 'Organizador Teste',
        ]);
    }

    public function test_raiz_redireciona_para_eventos(): void
    {
        $this->comoOrganizador()->get('/')->assertRedirect(route('eventos.index'));
    }

    public function test_index_lista_eventos(): void
    {
        Evento::create(['nome' => 'Posse Solene 2026', 'data' => '2026-06-10', 'local' => 'Plenário']);

        $this->comoOrganizador()->get('/eventos')
            ->assertOk()
            ->assertSee('Posse Solene 2026')
            ->assertSee('Solene Cerimonial');
    }

    public function test_form_de_criacao_abre(): void
    {
        $this->comoOrganizador()->get('/eventos/criar')
            ->assertOk()
            ->assertSee('Criar Novo Evento');
    }

    public function test_show_exibe_evento_e_convidado(): void
    {
        $evento = Evento::create(['nome' => 'Sessão Solene', 'data' => '2026-06-10', 'local' => 'Plenário']);
        $evento->convidados()->create([
            'nome' => 'ANA MARIA', 'cargo' => 'Juízes', 'cor' => 'blue', 'presente' => true,
        ]);

        $this->comoOrganizador()->get("/eventos/{$evento->id}")
            ->assertOk()
            ->assertSee('Sessão Solene')
            ->assertSee('ANA MARIA')
            ->assertSee('Lista de Convidados');
    }

    public function test_pagina_de_assentos_abre(): void
    {
        $evento = Evento::create(['nome' => 'Sessão', 'data' => '2026-06-10', 'local' => 'X']);

        $this->comoOrganizador()->get("/eventos/{$evento->id}/assentos")
            ->assertOk()
            ->assertSee('Distribuição de Assentos');
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests</subpasta>
  <nome_arquivo>TestCase.php</nome_arquivo>
  <caminho_completo>tests/TestCase.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests;

use Database\Seeders\AcessoSeeder;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Throwable;

abstract class TestCase extends BaseTestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->garantirGruposDeAcessoBasicos();
    }

    /**
     * Roda o AcessoSeeder pra cada teste: cria os grupos básicos
     * (SOLENE-ADMIN / SOLENE-ORGANIZADORES), sincroniza o catálogo de
     * rotas via acl:sync e vincula as rotas conforme o uso real.
     *
     * Necessário porque o AuthorizeRouteAccess valida cada requisição
     * contra o banco; sem essa seed qualquer teste com header Authelia
     * bateria 403. Idempotente.
     *
     * Testes sem RefreshDatabase (schema não migrado) ignoram em silêncio.
     */
    private function garantirGruposDeAcessoBasicos(): void
    {
        try {
            (new AcessoSeeder)->run();
        } catch (Throwable) {
            // Schema ainda não migrado → teste Unit sem RefreshDatabase.
        }
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Unit/Services</subpasta>
  <nome_arquivo>AssentosServiceTest.php</nome_arquivo>
  <caminho_completo>tests/Unit/Services/AssentosServiceTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Unit\Services;

use App\Models\Convidado;
use App\Models\Evento;
use App\Services\AssentosService;
use Illuminate\Support\Collection;
use PHPUnit\Framework\TestCase;

class AssentosServiceTest extends TestCase
{
    private function convidado(string $cor, bool $presente): Convidado
    {
        return new Convidado(['nome' => 'X', 'cargo' => 'Convidados', 'cor' => $cor, 'presente' => $presente]);
    }

    public function test_conta_presentes_por_cor(): void
    {
        $convidados = new Collection([
            $this->convidado('blue', true),
            $this->convidado('blue', true),
            $this->convidado('red', true),
            $this->convidado('green', false), // ausente não conta
        ]);

        $ocupacao = (new AssentosService)->ocupacaoPorCor($convidados);

        $this->assertSame(2, $ocupacao['blue']);
        $this->assertSame(1, $ocupacao['red']);
        $this->assertSame(0, $ocupacao['green']);
    }

    public function test_todas_as_cores_presentes_no_resultado(): void
    {
        $ocupacao = (new AssentosService)->ocupacaoPorCor(new Collection);

        foreach (Convidado::CORES as $cor) {
            $this->assertArrayHasKey($cor, $ocupacao);
            $this->assertSame(0, $ocupacao[$cor]);
        }
    }

    private function eventoComCapacidade(array $caps): Evento
    {
        // Sem 'data': o cast de data exige conexão para o formato, e o
        // mapa de assentos só depende das capacidades e dos convidados.
        return new Evento($caps);
    }

    private function sentado(string $cor, int $numero): Convidado
    {
        return new Convidado([
            'nome' => 'AUTORIDADE', 'cargo' => 'Convidados', 'cor' => $cor,
            'presente' => true, 'assento_numero' => $numero,
        ]);
    }

    public function test_mapa_posiciona_ocupantes_nas_poltronas(): void
    {
        $evento = $this->eventoComCapacidade([
            'cap_red' => 3, 'cap_blue' => 2, 'cap_green' => 0, 'cap_yellow' => 0,
        ]);
        $evento->setRelation('convidados', new Collection([
            $this->sentado('red', 1),
            $this->sentado('red', 3),
            $this->sentado('blue', 2),
            $this->convidado('blue', true), // presente, mas sem poltrona → ignorado
        ]));

        $mapa = (new AssentosService)->mapa($evento);

        $this->assertSame(5, $mapa['capacidade_total']);
        $this->assertSame(3, $mapa['ocupados']);
        $this->assertSame(2, $mapa['livres']);
        $this->assertSame(2, $mapa['categorias']['red']['ocupados']);
        $this->assertInstanceOf(Convidado::class, $mapa['categorias']['red']['assentos'][1]);
        $this->assertNull($mapa['categorias']['red']['assentos'][2]);
        $this->assertInstanceOf(Convidado::class, $mapa['categorias']['red']['assentos'][3]);
    }

    public function test_mapa_taxa_de_ocupacao(): void
    {
        $evento = $this->eventoComCapacidade([
            'cap_red' => 4, 'cap_blue' => 0, 'cap_green' => 0, 'cap_yellow' => 0,
        ]);
        $evento->setRelation('convidados', new Collection([
            $this->sentado('red', 1),
        ]));

        $mapa = (new AssentosService)->mapa($evento);

        $this->assertSame(25, $mapa['taxa']);
        $this->assertSame(25, $mapa['categorias']['red']['pct']);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Unit/Services</subpasta>
  <nome_arquivo>NominataServiceTest.php</nome_arquivo>
  <caminho_completo>tests/Unit/Services/NominataServiceTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Unit\Services;

use App\Models\Convidado;
use App\Services\NominataService;
use Illuminate\Support\Collection;
use PHPUnit\Framework\TestCase;

class NominataServiceTest extends TestCase
{
    private function convidado(string $nome, string $cargo, bool $presente): Convidado
    {
        return new Convidado([
            'nome' => $nome,
            'cargo' => $cargo,
            'cor' => 'blue',
            'presente' => $presente,
        ]);
    }

    public function test_agrupa_apenas_presentes_por_cargo(): void
    {
        $convidados = new Collection([
            $this->convidado('ANA', 'Juízes', true),
            $this->convidado('BRUNO', 'Juízes', false),
            $this->convidado('CARLA', 'Desembargadores', true),
        ]);

        $grupos = (new NominataService)->agrupar($convidados);

        $this->assertArrayHasKey('Desembargadores', $grupos);
        $this->assertArrayHasKey('Juízes', $grupos);
        $this->assertCount(1, $grupos['Juízes']); // BRUNO (ausente) fora
    }

    public function test_respeita_a_ordem_protocolar_dos_cargos(): void
    {
        $convidados = new Collection([
            $this->convidado('ANA', 'Convidados', true),
            $this->convidado('BRUNO', 'Mesa de Honra', true),
            $this->convidado('CARLA', 'Juízes', true),
        ]);

        $ordem = array_keys((new NominataService)->agrupar($convidados));

        $this->assertSame(['Mesa de Honra', 'Juízes', 'Convidados'], $ordem);
    }

    public function test_ordena_nomes_dentro_do_cargo(): void
    {
        $convidados = new Collection([
            $this->convidado('ZÉ', 'Juízes', true),
            $this->convidado('ANA', 'Juízes', true),
        ]);

        $grupos = (new NominataService)->agrupar($convidados);
        $nomes = array_map(fn (Convidado $c) => $c->nome, $grupos['Juízes']);

        $this->assertSame(['ANA', 'ZÉ'], $nomes);
    }

    public function test_omite_cargos_sem_presentes(): void
    {
        $convidados = new Collection([
            $this->convidado('ANA', 'Juízes', false),
        ]);

        $this->assertSame([], (new NominataService)->agrupar($convidados));
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>tests</pasta>
  <subpasta>tests/Unit</subpasta>
  <nome_arquivo>SmokeTest.php</nome_arquivo>
  <caminho_completo>tests/Unit/SmokeTest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Tests\Unit;

use Tests\TestCase;

class SmokeTest extends TestCase
{
    public function test_o_harness_de_testes_esta_funcionando(): void
    {
        $this->assertTrue(true);
    }
}

```
  </conteudo>
</arquivo>

