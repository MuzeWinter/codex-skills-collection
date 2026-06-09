# Codex Skills Collection

> 个人 Codex 技能全集，一键部署到任意电脑
> 更新时间：2026-06-09
> 技能总数：32 个 | 插件：3 个

---

## 快速开始

### Windows
```powershell
git clone https://github.com/Muze/codex-skills-collection.git
cd codex-skills-collection
.\setup.ps1
```

### macOS / Linux
```bash
git clone https://github.com/Muze/codex-skills-collection.git
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

## 插件依赖

以下 Codex 插件需另行安装：
- **Browser** — 浏览器自动化
- **Chrome** — Chrome 浏览器控制
- **Computer Use** — Windows 桌面自动化
