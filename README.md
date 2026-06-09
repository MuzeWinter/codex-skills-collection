# Codex Skills Collection

> 个人 Codex 技能全集，一键部署到任意电脑
> 更新时间：2026-06-09
> 技能总数：52 个技能 + 8 个插件 | 插件：3 个

---

## 快速开始

### Windows
```powershell
git clone https://github.com/MuzeWinter/codex-skills-collection.git
cd codex-skills-collection
.\setup.ps1
```

### macOS / Linux
```bash
git clone https://github.com/MuzeWinter/codex-skills-collection.git
cd codex-skills-collection
cp -r skills/* "$CODEX_HOME/skills/"
```

重启 Codex 即可。

---

## 技能目录

### 开发流程 — Superpowers
| 技能 | 来源 |
|------|------|
| brainstorming | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-plans | [obra/superpowers](https://github.com/obra/superpowers) |
| executing-plans | [obra/superpowers](https://github.com/obra/superpowers) |
| test-driven-development | [obra/superpowers](https://github.com/obra/superpowers) |
| systematic-debugging | [obra/superpowers](https://github.com/obra/superpowers) |
| subagent-driven-development | [obra/superpowers](https://github.com/obra/superpowers) |
| dispatching-parallel-agents | [obra/superpowers](https://github.com/obra/superpowers) |
| requesting-code-review | [obra/superpowers](https://github.com/obra/superpowers) |
| receiving-code-review | [obra/superpowers](https://github.com/obra/superpowers) |
| verification-before-completion | [obra/superpowers](https://github.com/obra/superpowers) |
| finishing-a-development-branch | [obra/superpowers](https://github.com/obra/superpowers) |
| using-git-worktrees | [obra/superpowers](https://github.com/obra/superpowers) |
| using-superpowers | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-skills | [obra/superpowers](https://github.com/obra/superpowers) |

### 设计 & 体验
| 技能 | 来源 |
|------|------|
| ui-ux-pro-max | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| **product-design-resources** | [ttt30ga/awesome-product-design](https://github.com/ttt30ga/awesome-product-design) — 本地定制 |

### 操控 & 自动化
| 技能 | 来源 |
|------|------|
| **computer-use** | Codex Computer Use 插件内置 |
| **control-in-app-browser** | Codex Browser 插件内置 |
| **control-chrome** | Codex Chrome 插件内置 |

### 补充增强 — Matt Pocock
| 技能 | 来源 |
|------|------|
| grill-with-docs | [mattpocock/skills](https://github.com/mattpocock/skills) |
| caveman | [mattpocock/skills](https://github.com/mattpocock/skills) |
| git-guardrails | [mattpocock/skills](https://github.com/mattpocock/skills) |
| handoff | [mattpocock/skills](https://github.com/mattpocock/skills) |

### 部署 & 工具
| 技能 | 来源 |
|------|------|
| vercel-deploy | [openai/skills](https://github.com/openai/skills) |
| screenshot | [openai/skills](https://github.com/openai/skills) |
| security-best-practices | [openai/skills](https://github.com/openai/skills) |
| **codex-windows-fast-patch** | 本地定制 |

### 代码理解 — Understand-Anything
| 技能 | 来源 |
|------|------|
| understand | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-chat | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-dashboard | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-diff | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-domain | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-explain | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-knowledge | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |
| understand-onboard | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |

---

## 工作流

```
grill-with-docs -> brainstorming -> writing-plans -> caveman + TDD -> verification -> handoff
    (追问)              (Superpowers)                    (极简实现)        (交接)
                                git-guardrails 全程护航
                                         ->          vercel-deploy 一键上线
```

---

## 更新技能

当上游技能更新时，重新运行 skill-installer 覆盖：

```bash
# 示例：更新 Superpowers 系列
skill-installer --repo obra/superpowers --path skills/brainstorming --name brainstorming
```

本地定制技能（product-design-resources、codex-windows-fast-patch）需手动更新后重新复制到仓库。

---

## 包含的插件

| 插件 | 来源 | 说明 |
|------|------|------|
| Browser | Codex 内置 | 内置浏览器操控 |
| Chrome | Codex 内置 | Chrome 浏览器自动化 |
| Computer Use | [codex-windows-fast-patch](https://github.com/MuzeWinter/codex-windows-fast-patch-skill) | Windows 桌面操控 |
| Figma | Codex 市场 | 设计稿转代码、组件库生成 |
| GitHub | Codex 市场 | 仓库/PR/Issue 管理 |
| Sentry | Codex 市场 | 线上报错监控 |
| Supabase | Codex 市场 | 后端即服务 |
| Neon Postgres | Codex 市场 | Serverless PostgreSQL |

> setup.ps1 自动部署  
> Browser/Chrome 随 Codex 桌面端发布  
> Computer Use 由 [codex-windows-fast-patch](https://github.com/MuzeWinter/codex-windows-fast-patch-skill) 启用  
> 市场插件通过 Codex 内置市场分发
> 内置插件随 Codex 桌面端发布，无独立 GitHub 仓库
> 市场插件通过 Codex 内置市场分发，也无外部仓库地址

---

## 插件依赖

以下 Codex 插件需另行安装：
- **Browser** — 浏览器自动化
- **Chrome** — Chrome 浏览器控制
- **Computer Use** — Windows 桌面自动化
